data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rgrp[0].name
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  tags                     = var.tags

  is_hns_enabled = var.enable_hierarchical_namespace

  # Bloco dinâmico para habilitar FileStorage apenas se o tier for Standard
  # dynamic "share_properties" {
  #   for_each = var.account_tier == "Standard" && var.create_file_share ? [1] : []
  #   content {
  #     cors_rule {
  #       allowed_headers    = ["*"]
  #       allowed_methods    = ["GET", "POST", "PUT", "DELETE"]
  #       allowed_origins    = ["*"]
  #       exposed_headers    = ["*"]
  #       max_age_in_seconds = 3600
  #     }
  #   }
  # }
}

resource "azurerm_storage_container" "_" {
  count                 = var.create_blob_containers ? length(var.storage_container_name) : 0
  name                  = var.storage_container_name[count.index]
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = var.container_access_type[count.index]
}

resource "azurerm_storage_share" "_" {
  count              = var.create_file_shares ? length(var.file_share_name) : 0
  name               = var.file_share_name[count.index]
  storage_account_id = azurerm_storage_account.storage.id
  quota              = var.file_share_quota[count.index]
  access_tier        = var.file_share_access_tier[count.index]
}

resource "azurerm_storage_table" "_" {
  count                = var.create_tables ? length(var.table_name) : 0
  name                 = var.table_name[count.index]
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_queue" "_" {
  count                = var.create_queues ? length(var.queue_name) : 0
  name                 = var.queue_name[count.index]
  storage_account_name = azurerm_storage_account.storage.name
}
