output "resource_group_name" {
  description = "Resource Group Name"
  value       = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rgrp[0].name
}

output "resource_group_location" {
  description = "Resource Group Location"
  value       = var.create_resource_group ? azurerm_resource_group.rg[0].location : data.azurerm_resource_group.rgrp[0].location
}

output "storage_account_name" {
  description = "Nome da conta de armazenamento criada"
  value       = azurerm_storage_account.storage.name
}
output "storage_account_id" {
  description = "ID da conta de armazenamento criada"
  value       = azurerm_storage_account.storage.id
}

output "storage_container_name" {
  description = "Nome do container de armazenamento criado"
  value       = var.create_storage_container ? azurerm_storage_container._[0].name : null
}

output "storage_container_names" {
  description = "Lista de nomes dos containers de armazenamento criados"
  value       = var.create_storage_container ? azurerm_storage_container._[*].name : []
}

output "file_share_name" {
  description = "Nome do file share criado"
  value       = var.create_file_share ? azurerm_storage_share._[0].name : null
}

output "file_share_names" {
  description = "Lista de nomes dos file shares criados"
  value       = var.create_file_share ? azurerm_storage_share._[*].name : []
}

output "blob_container_names" {
  description = "Lista de nomes dos containers de blob criados"
  value       = var.create_blob_containers ? azurerm_storage_container._[*].name : []
}

output "table_names" {
  description = "Lista de nomes das tabelas criadas"
  value       = var.create_tables ? azurerm_storage_table._[*].name : []
}

output "queue_names" {
  description = "Lista de nomes das filas criadas"
  value       = var.create_queues ? azurerm_storage_queue._[*].name : []
}
