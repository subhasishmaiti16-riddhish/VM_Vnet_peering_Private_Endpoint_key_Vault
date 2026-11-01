data "azurerm_virtual_network" "vnet1" {
  for_each            = var.peering
  name                = each.value.vnet_name_security
  resource_group_name = each.value.rg_name

}
data "azurerm_virtual_network" "vnet2" {
  for_each            = var.peering
  name                = each.value.vnet_name_endpoint
  resource_group_name = each.value.rg_name
}
