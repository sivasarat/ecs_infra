# CLUSTER
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  tags = merge({
    Name = var.cluster_name
  }, local.common_tags)
}

# ECS TASK DEFINITION
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "Alpine Nginx"
      image     = "ngnix"
      cpu       = 1
      memory    = 512
      essential = true
      environment = [
        {
          "name"  = "VARNAME"
          "value" = "VARVAL"
        }
      ]
      network_mode = "bridge"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

# ECS SERVICE
resource "aws_ecs_service" "nginx" {
  name                               = "COMPANY-X-Microservice"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                      = var.desired_count
  iam_role                           = var.ecs_role_arn
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "nginx"
    container_port   = 8080
  }

}

# IAM ROLE


# IAM POLICY


# CLOUD WATCH LOG GROUP
resource "aws_cloudwatch_log_group" "CW_log_group" {
  name = var.CW_log_group
  tags = merge({
    Name = var.CW_log_group
  }, local.common_tags)
}



