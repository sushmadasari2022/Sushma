resource "databricks_mws_workspaces" "workspace" {
  provider        = databricks.mws
  account_id      = var.databricks_account_id
  aws_region      = var.region
  workspace_name  = local.prefix

  credentials_id           = databricks_mws_credentials.credentials.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.storage.storage_configuration_id
  network_id               = databricks_mws_networks.databricks.network_id

  token {
    comment = "Terraform"
  }
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "databricks_token" {
  value     = databricks_mws_workspaces.this.token[0].token_value
  sensitive = true
}