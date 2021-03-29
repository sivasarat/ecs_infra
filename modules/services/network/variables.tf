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

variable "resource_count" {
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