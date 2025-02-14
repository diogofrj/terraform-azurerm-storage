<!-- BEGIN_TF_DOCS -->
# 📂 Módulo de Storage Account Azure - Terraform

<a href="#"><img src="https://raw.githubusercontent.com/diogofrj/terraform-azurerm-storage/refs/heads/main/docs/banner.svg" /></a>



## Índice

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container._](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue._](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_share._](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_table._](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Localização do Azure onde os recursos serão criados | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do grupo de recursos | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Tipo de conta de armazenamento (StorageV2, BlobStorage, FileStorage, BlockBlobStorage) | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Tipo de replicação da conta de armazenamento (LRS, GRS, RAGRS, ZRS) | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier da conta de armazenamento (Standard ou Premium) | `string` | `"Standard"` | no |
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | Tipo de acesso do container (blob, container ou private) | `list(string)` | <pre>[<br/>  "private"<br/>]</pre> | no |
| <a name="input_create_blob_containers"></a> [create\_blob\_containers](#input\_create\_blob\_containers) | Controla se os containers de blob devem ser criados | `bool` | `false` | no |
| <a name="input_create_file_share"></a> [create\_file\_share](#input\_create\_file\_share) | Controla se o file share deve ser criado | `bool` | `false` | no |
| <a name="input_create_file_shares"></a> [create\_file\_shares](#input\_create\_file\_shares) | Controla se os file shares devem ser criados | `bool` | `false` | no |
| <a name="input_create_queues"></a> [create\_queues](#input\_create\_queues) | Controla se as filas devem ser criadas | `bool` | `false` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Controla se o grupo de recursos deve ser criado (true) ou usar um existente (false) | `bool` | `true` | no |
| <a name="input_create_storage_container"></a> [create\_storage\_container](#input\_create\_storage\_container) | Controla se o container de armazenamento deve ser criado | `bool` | `false` | no |
| <a name="input_create_tables"></a> [create\_tables](#input\_create\_tables) | Controla se as tabelas devem ser criadas | `bool` | `false` | no |
| <a name="input_enable_hierarchical_namespace"></a> [enable\_hierarchical\_namespace](#input\_enable\_hierarchical\_namespace) | Habilita o namespace hierárquico para Azure Data Lake Storage Gen2 | `bool` | `false` | no |
| <a name="input_file_share_access_tier"></a> [file\_share\_access\_tier](#input\_file\_share\_access\_tier) | Nível de acesso do file share (Hot, Cool, TransactionOptimized para Standard tier, Premium para Premium tier) | `list(string)` | <pre>[<br/>  "Hot"<br/>]</pre> | no |
| <a name="input_file_share_name"></a> [file\_share\_name](#input\_file\_share\_name) | Nome do file share. Se não informado, nenhum file share será criado | `list(string)` | `[]` | no |
| <a name="input_file_share_quota"></a> [file\_share\_quota](#input\_file\_share\_quota) | Quota do file share em GB | `list(number)` | <pre>[<br/>  100<br/>]</pre> | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | Nome da fila. Se não informado, nenhuma fila será criada | `list(string)` | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `"aaaaaaaaaaaaaaaaaaaaaaaa"` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Nome do container de armazenamento. Se não informado, nenhum container será criado | `list(string)` | `[]` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | Nome da tabela. Se não informado, nenhuma tabela será criada | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags a serem aplicadas aos recursos | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob_container_names"></a> [blob\_container\_names](#output\_blob\_container\_names) | Lista de nomes dos containers de blob criados |
| <a name="output_file_share_name"></a> [file\_share\_name](#output\_file\_share\_name) | Nome do file share criado |
| <a name="output_file_share_names"></a> [file\_share\_names](#output\_file\_share\_names) | Lista de nomes dos file shares criados |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | Lista de nomes das filas criadas |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | Resource Group Location |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource Group Name |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | ID da conta de armazenamento criada |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Nome da conta de armazenamento criada |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | Nome do container de armazenamento criado |
| <a name="output_storage_container_names"></a> [storage\_container\_names](#output\_storage\_container\_names) | Lista de nomes dos containers de armazenamento criados |
| <a name="output_table_names"></a> [table\_names](#output\_table\_names) | Lista de nomes das tabelas criadas |

<!-- END_TF_DOCS -->