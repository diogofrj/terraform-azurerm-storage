# 📂 Módulo de Storage Account Azure - Terraform

Este módulo permite criar e gerenciar Storage Accounts no Azure com diferentes tipos de recursos de armazenamento como Blob Containers, File Shares, Tables e Queues.

## 📋 Pré-requisitos

- Terraform >= 1.10
- Provider AzureRM >= 4.17.0
- Acesso a uma subscrição do Azure com permissões para criar recursos

## 🚀 Como usar

### Exemplo básico de uso do módulo:

```hcl
module "labels" {
  source       = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/labels?ref=v0.0.1"
  project      = "myapp"
  environment  = "dev"
  region       = "eastus2"
}

module "storage" {
  source                   = "git::https://github.com/diogofrj/terraform-azurerm-storage.git?ref=v0.1.0"

  create_resource_group    = true
  resource_group_name      = module.labels.resource_group_name
  location                 = module.labels.region
  storage_account_name     = module.labels.storage_name
  account_tier            = "Standard"  # Ou "Premium"
  account_kind            = "BlobStorage"
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
```

### TODO

- [ ] Validar condicionais com account_tier Premium
- [ ] Inserir configurações para rede publica/privada
- [ ] Publicar no registry do terraform
