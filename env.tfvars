region = "eu-west-1"

# --------------------------------------------
# Network values
# --------------------------------------------
vpc_cidr       = "10.0.0.0/16"
public_cidr    = "10.0.1.0/24"
private_cidr   = "10.0.2.0/24"
resource_count = 2

# --------------------------------------------
# Cluster values
# --------------------------------------------
cluster_name                       = "COMPNAY-X-ECS-Cluster"
CW_log_group                       = "COMPANY-X-Logs"
desired_count                      = 1
deployment_maximum_percent         = 100
deployment_minimum_healthy_percent = 0

# --------------------------------------------
# Tag values
# --------------------------------------------
service_tag = "aws"
owner_tag   = "utrack"
task_tag    = "assignment"

# --------------------------------------------
# alb values
# --------------------------------------------
alb_name = "COMPNAY-X-ALB"
