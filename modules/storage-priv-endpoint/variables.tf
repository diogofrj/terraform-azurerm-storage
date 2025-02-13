variable "create_private_dns_zones" {
  description = "Indica se as zonas DNS privadas devem ser criadas"
  type        = bool
  default     = true

}

variable "resource_group_name" {
  description = "Nome do grupo de recursos onde os recursos serão criados"
  type        = string
}

variable "location" {
  description = "Localização do Azure onde os recursos serão criados"
  type        = string
}

variable "storage_account_name" {
  description = "Nome da conta de armazenamento"
  type        = string
}

# variable "name" {
#   description = "Nome base para os private endpoints"
#   type        = string
#   validation {
#     condition     = can(regex("^privatelink\\.(dfs|web|blob|queue|table|file)\\.core\\.windows\\.net$", var.name))
#     error_message = "O nome deve estar no formato 'privatelink.[service].core.windows.net' onde [service] pode ser: dfs, web, blob, queue, table ou file"
#   }
# }

variable "subnet_id" {
  description = "ID da subnet onde os private endpoints serão criados"
  type        = string
}

variable "private_service_connection_name" {
  description = "Nome base para as conexões de serviço privado"
  type        = string
}

variable "private_connection_resource_id" {
  description = "ID do recurso de storage account para conexão privada"
  type        = string
}

variable "is_manual_connection" {
  description = "Indica se a conexão privada será manual"
  type        = bool
  default     = false
}
variable "custom_network_interface_name" {
  description = "Nome base para a interface de rede privada"
  type        = string
}
variable "private_dns_zone_group_name" {
  description = "Nome base para os grupos de zona DNS privada"
  type        = string
}

variable "enabled_storage_services" {
  description = "Lista de serviços de storage que terão private endpoints habilitados"
  type        = list(string)
  default     = ["blob", "file", "table", "queue", "dfs", ]
  validation {
    condition     = alltrue(flatten([for service in var.enabled_storage_services : can(regex("^blob|file|table|queue|dfs$", service))]))
    error_message = "Os serviços devem ser um dos seguintes: blob, file, table, queue, dfs"
  }
}

variable "private_dns_zone_virtual_network_link_name" {
  description = "Nome base para os links de rede virtual da zona DNS privada"
  type        = string
}

variable "virtual_network_id" {
  description = "ID da rede virtual para criar os links DNS"
  type        = string
  default     = null
  validation {
    condition     = var.virtual_network_id == null || var.virtual_network_id != ""
    error_message = "O ID da rede virtual não pode estar vazio"
  }
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
