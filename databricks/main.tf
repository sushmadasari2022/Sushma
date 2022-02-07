terraform {
    required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.49.0"
    }
  }
  backend "s3" {
    bucket = "network-vpc"
    key    = "databricks_tf"
    region = "us-east-2"
  }
}


provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token = var.aws_token
}

module "databricks_workspace" {
  source                              = "./databricks_workspace
  databricks_account_username         = var.databricks_account_username
  databricks_account_password         = var.databricks_account_password
  databricks_account_id               = var.databricks_account_id
  region                              = var.region
  aws_access_key                      = var.aws_access_key
  aws_secret_key                      = var.aws_secret_key
  aws_token                           = var.aws_token
}

module "databricks_cluster" {
  source  = "./databricks_cluster"
  databricks_host = module.databricks_workspace.databricks_host
  databricks_token = module.databricks_workspace.databricks_token 
}

output "databricks_host" {
  value = module.databricks_workspace.databricks_host
}

output "databricks_token" {
  value     = module.databricks_workspace.databricks_host
  sensitive = true
}