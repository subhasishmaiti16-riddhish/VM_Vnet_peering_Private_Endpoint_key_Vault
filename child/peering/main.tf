resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
    for_each = var.peering
  name                      = each.value.peering_name1
  resource_group_name       = each.value.rg_name
  virtual_network_name      = each.value.vnet_name_security
  remote_virtual_network_id = data.azurerm_virtual_network.vnet2[each.key].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
    for_each = var.peering
  name                      = each.value.peering_name2
  resource_group_name       = each.value.rg_name
  virtual_network_name      = each.value.vnet_name_endpoint
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1[each.key].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}