# CLUSTER
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  tags = merge({
    Name = var.cluster_name
  }, local.common_tags)
}

# ECS TASK DEFINITION
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "service"
  execution_role_arn       = var.ecs_role_arn
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      name   = "nginx"
      image  = "ngnix"
      cpu    = 1
      memory = 512
      environment = [
        {
          "name"  = "VARNAME"
          "value" = "VARVAL"
        }
      ]
      network_mode = "bridge"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

# ECS SERVICE
resource "aws_ecs_service" "nginx" {
  name                               = "COMPANY-X-Microservice"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  launch_type                        = "EC2"
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.alb_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group
    container_name   = "nginx"
    container_port   = 8080
  }

}

# CLOUD WATCH LOG GROUP
resource "aws_cloudwatch_log_group" "CW_log_group" {
  name              = var.CW_log_group
  retention_in_days = 30

  tags = merge({
    Name = var.CW_log_group
  }, local.common_tags)
}