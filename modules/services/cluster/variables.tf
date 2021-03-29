#--------------------------------
# Common variables
#--------------------------------
variable "region" {
  type = string
}

#--------------------------------
# Cluster variables
#--------------------------------
variable "cluster_name" {
  type = string
}

variable "CW_log_group" {
  type = string
}

variable "ecs_role_arn" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "deployment_maximum_percent" {
  type = number
}

variable "deployment_minimum_healthy_percent" {
  type = number
}

variable "alb_target_group" {
  type = string
}

#--------------------------------
# Tag variables
#--------------------------------
variable "service_tag" {
  type = string
}

variable "owner_tag" {
  type = string
}

variable "task_tag" {
  type = string
}