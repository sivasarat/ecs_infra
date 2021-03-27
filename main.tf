provider "aws" {
  region = var.region
}

module "network" {
  source       = "./modules/services/network"
  service_tag  = var.service_tag
  owner_tag    = var.owner_tag
  task_tag     = var.task_tag
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  public_cidr  = var.public_cidr
  private_cidr = var.private_cidr
}

module "iam" {
  source      = "./modules/services/iam"
  service_tag = var.service_tag
  owner_tag   = var.owner_tag
  task_tag    = var.task_tag
  region      = var.region
  depends_on = [
    module.network
  ]
}

module "cluster" {
  source                             = "./modules/services/cluster"
  service_tag                        = var.service_tag
  owner_tag                          = var.owner_tag
  task_tag                           = var.task_tag
  region                             = var.region
  cluster_name                       = var.cluster_name
  CW_log_group                       = var.CW_log_group
  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  ecs_role_arn                       = module.iam.ecs_role_arn
  depends_on = [
    module.iam
  ]
}