provider "databricks" {
  token    = var.databricks_token
  host     = var.databricks_host
}
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
}