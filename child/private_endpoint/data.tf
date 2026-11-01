data "azurerm_subnet" "subnet" {
  for_each = var.endpoint
  name                 = each.value.endpoint_subnet_name
  virtual_network_name = each.value.endpoint_vnet_name
  resource_group_name  = each.value.resource_group_name
  
}
data "azurerm_virtual_network" "vnet" {
  for_each = var.endpoint
  name                = each.value.endpoint_vnet_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_storage_account" "storage" {
  for_each = var.endpoint
  name                = each.value.endpoint_storage_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_virtual_network" "vm_vnet" {
  for_each = var.endpoint
  name                = each.value.endpoint_vm_vnet_name
  resource_group_name = each.value.resource_group_name
}