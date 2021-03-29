#--------------------------------
# Common variables
#--------------------------------
variable "region" {
  type = string
}

#--------------------------------
# Network variables
#--------------------------------
variable "vpc_cidr" {
  type = string
}

variable "public_cidr" {
  type = string
}

variable "private_cidr" {
  type = string
}

#--------------------------------
# cluster variables
#--------------------------------
variable "cluster_name" {
  type = string
}

variable "CW_log_group" {
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

#--------------------------------
# alb variables
#--------------------------------

variable "alb_name" {
  default     = "default"
  description = "The name of the loadbalancer"
}

variable "deregistration_delay" {
  default     = "300"
  description = "The default deregistration delay"
}

variable "health_check_path" {
  default     = "/"
  description = "The default health check path"
}

variable "allow_cidr_block" {
  default     = ["0.0.0.0/0"]
  description = "Specify cidr block that is allowed to access the LoadBalancer"
}