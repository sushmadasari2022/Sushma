data "databricks_node_type" "small" {
  local_disk = true
#  depends_on = [var.databricks_host]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on = [var.databricks_host]
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "sam-db-cluster"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  aws_attributes {
    availability           = "SPOT"
    zone_id                = "us-west-2"
    first_on_demand        = 1
    spot_bid_price_percent = 100
  }
}
