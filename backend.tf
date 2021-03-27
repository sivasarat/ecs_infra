terraform {
  backend "s3" {
    bucket = "bucket36991"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-1"
  }
  required_providers {
    aws = {
      version = ">= 3.25.0"
      source  = "hashicorp/aws"
    }
  }
}