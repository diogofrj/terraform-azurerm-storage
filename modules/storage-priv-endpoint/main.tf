
# Get existing private DNS zones if they exist
data "azurerm_private_dns_zone" "storage_dns_zones" {
  for_each            = var.create_private_dns_zones == false ? toset(var.enabled_storage_services) : []
  name                = "privatelink.${each.key}.core.windows.net"
  resource_group_name = var.resource_group_name
}

# Create private DNS zones if they don't exist
resource "azurerm_private_dns_zone" "storage_dns_zones" {
  for_each            = var.create_private_dns_zones ? toset(var.enabled_storage_services) : []
  name                = "privatelink.${each.key}.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

# Create private endpoints for each storage service
resource "azurerm_private_endpoint" "storage_priv_endpoints" {
  for_each            = toset(var.enabled_storage_services)
  name                = "${var.storage_account_name}-${each.key}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.private_service_connection_name}-${each.key}"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = [each.key]
  }
  custom_network_interface_name = "${var.storage_account_name}-${each.key}-nic"
  private_dns_zone_group {
    name = "${var.private_dns_zone_group_name}-${each.key}"
    private_dns_zone_ids = [
      var.create_private_dns_zones ? azurerm_private_dns_zone.storage_dns_zones[each.key].id : data.azurerm_private_dns_zone.storage_dns_zones[each.key].id
    ]
  }

  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

# Create virtual network links for each DNS zone
resource "azurerm_private_dns_zone_virtual_network_link" "storage_vnet_links" {
  for_each              = toset(var.enabled_storage_services)
  name                  = "${var.private_dns_zone_virtual_network_link_name}-${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.create_private_dns_zones ? azurerm_private_dns_zone.storage_dns_zones[each.key].name : data.azurerm_private_dns_zone.storage_dns_zones[each.key].name
  virtual_network_id    = try(var.virtual_network_id, null)
  tags                  = var.tags
}
