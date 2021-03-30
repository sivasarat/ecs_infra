#--------------------------------
# Common variables
#--------------------------------
variable "region" {
  type = string
}

variable "resource_count" {
  type = string
}

#--------------------------------
# alb variables
#--------------------------------
variable "alb_name" {
  default     = "default"
  description = "The name of the loadbalancer"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids to place the loadbalancer in"
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids to place the loadbalancer in"
}

variable "vpc_id" {
  description = "The VPC id"
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