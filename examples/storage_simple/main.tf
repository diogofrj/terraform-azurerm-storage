module "labels" {
  source       = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/labels?ref=v0.0.1"
  project      = "myapp"
  environment  = "dev"
  region       = "eastus2"
}

resource "random_string" "random_name" {
  length  = 4
  special = false
  upper   = false
}


resource "azurerm_resource_group" "this" {
  location = module.labels.region
  name     = module.labels.resource_group_name
}

module "storage" {
  source                   = "../../"
  create_resource_group    = false
  resource_group_name      = azurerm_resource_group.this.name
  location                 = module.labels.region
  storage_account_name     = "${module.labels.storage_name}-${random_string.random_name.result}"
  account_tier            = "Standard"  # Ou "Premium"
  account_kind            = "StorageV2"
  account_replication_type = "LRS"
  enable_hierarchical_namespace = true

  create_blob_containers = true
  storage_container_name = ["container1", "container2"]
  container_access_type  = ["private", "blob"]

  create_file_shares = false
  file_share_name    = ["share1", "share2"]
  file_share_quota   = [100, 200]
  file_share_access_tier = ["Hot", "Cool"]

  create_tables = false
  table_name    = ["table1", "table2"]

  create_queues = false
  queue_name    = ["queue1", "queue2"]

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}


