resource "azurerm_private_endpoint" "storage_pe" {
  for_each            = var.endpoint
  name                = each.value.endpoint_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet[each.key].id

  private_service_connection {
    name                           = each.value.endpoint_blob_name
    private_connection_resource_id = data.azurerm_storage_account.storage[each.key].id
    subresource_names              = each.value.endpoint_subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = each.value.endpoint_dns_zone_group_name

    private_dns_zone_ids = [
      azurerm_private_dns_zone.storage_dns[each.key].id
    ]
  }
}

resource "azurerm_private_dns_zone" "storage_dns" {
  for_each = var.endpoint

  name                = each.value.endpoint_dns_zone_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_dns_link" {
  for_each = var.endpoint

  name = each.value.endpoint_dns_zone_link_name

  private_dns_zone_id = azurerm_private_dns_zone.storage_dns[each.key].id

  virtual_network_id = data.azurerm_virtual_network.vnet[each.key].id

  registration_enabled = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "vm_vnet_link" {
  for_each = var.endpoint
  name                  = each.value.endpoint_dns_vnet_zone_link_name
  private_dns_zone_id   = azurerm_private_dns_zone.storage_dns[each.key].id
  virtual_network_id    = data.azurerm_virtual_network.vm_vnet[each.key].id
  registration_enabled = false
}
