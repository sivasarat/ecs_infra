
resource "aws_lb_target_group" "tg" {
  name                 = "${var.alb_name}-target-group"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
  }

  tags = merge({
    Name = "${var.alb_name}-target-group"
  }, local.common_tags)
}

resource "aws_lb" "alb" {
  name               = var.alb_name
  subnets            = var.public_subnet_ids
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]

  tags = merge({
    Name = var.alb_name
  }, local.common_tags)
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.node.id
  port             = 80
}

resource "aws_instance" "node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = merge({
    Name = "nginx-node"
  }, local.common_tags)
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.id
    type             = "forward"
  }
}

resource "aws_security_group" "alb" {
  name   = "${var.alb_name}_alb"
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.alb_name}_security_group"
  }, local.common_tags)
}

resource "aws_security_group_rule" "https_from_anywhere" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = var.allow_cidr_block
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}