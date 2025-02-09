variable "create_resource_group" {
  description = "Controla se o grupo de recursos deve ser criado (true) ou usar um existente (false)"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "location" {
  description = "Localização do Azure onde os recursos serão criados"
  type        = string
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Nome da conta de armazenamento"
  type        = string
}

variable "account_tier" {
  description = "Tier da conta de armazenamento (Standard ou Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "O account_tier deve ser 'Standard' ou 'Premium'."
  }
}

variable "account_kind" {
  description = "Tipo de conta de armazenamento (StorageV2, BlobStorage, FileStorage, BlockBlobStorage)"
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.account_kind)
    error_message = "O account_kind deve ser um dos valores válidos: StorageV2, BlobStorage, FileStorage, BlockBlobStorage."
  }
}

variable "account_replication_type" {
  description = "Tipo de replicação da conta de armazenamento (LRS, GRS, RAGRS, ZRS)"
  type        = string
  default     = "LRS"
}

variable "enable_hierarchical_namespace" {
  description = "Habilita o namespace hierárquico para Azure Data Lake Storage Gen2"
  type        = bool
  default     = false
}

variable "create_blob_containers" {
  description = "Controla se os containers de blob devem ser criados"
  type        = bool
  default     = false
}

variable "create_file_shares" {
  description = "Controla se os file shares devem ser criados"
  type        = bool
  default     = false
}

variable "create_tables" {
  description = "Controla se as tabelas devem ser criadas"
  type        = bool
  default     = false
}

variable "create_queues" {
  description = "Controla se as filas devem ser criadas"
  type        = bool
  default     = false
}

# Criar containers blob
variable "create_storage_container" {
  description = "Controla se o container de armazenamento deve ser criado"
  type        = bool
  default     = false
}

variable "storage_container_name" {
  description = "Nome do container de armazenamento. Se não informado, nenhum container será criado"
  type        = list(string)
  default     = []
}

variable "container_access_type" {
  description = "Tipo de acesso do container (blob, container ou private)"
  type        = list(string)
  default     = ["private"]
}

# Criar File Share
variable "create_file_share" {
  description = "Controla se o file share deve ser criado"
  type        = bool
  default     = false

#   validation {
#     condition     = var.create_file_share == false || (var.create_file_share == true && ((var.account_tier == "Standard" && var.account_kind == "StorageV2") || (var.account_tier == "Premium" && var.account_kind == "FileStorage" && var.file_share_quota[0] >= 100)))
#     error_message = "File Share só pode ser criado em contas de armazenamento Standard com account_kind StorageV2 ou Premium com account_kind FileStorage (neste caso a quota mínima é 100GB)."
#   }
}

variable "file_share_name" {
  description = "Nome do file share. Se não informado, nenhum file share será criado"
  type        = list(string)
  default     = []
}

variable "file_share_quota" {
  description = "Quota do file share em GB"
  type        = list(number)
  default     = [100]
}

variable "file_share_access_tier" {
  description = "Nível de acesso do file share (Hot, Cool, TransactionOptimized para Standard tier, Premium para Premium tier)"
  type        = list(string)
  default     = ["Hot"]

  validation {
    condition     = alltrue([
      for tier in var.file_share_access_tier : 
        var.account_tier == "Premium" ? tier == "Premium" : contains(["Hot", "Cool", "TransactionOptimized"], tier)
    ])
    error_message = "Para account_tier Premium, file_share_access_tier deve ser Premium. Para Standard, pode ser Hot, Cool ou TransactionOptimized."
  }
}

variable "table_name" {
  description = "Nome da tabela. Se não informado, nenhuma tabela será criada"
  type        = list(string)
  default     = []
}

variable "queue_name" {
  description = "Nome da fila. Se não informado, nenhuma fila será criada"
  type        = list(string)
  default     = []
}
