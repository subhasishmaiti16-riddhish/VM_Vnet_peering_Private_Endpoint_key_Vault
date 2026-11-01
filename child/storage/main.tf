resource "azurerm_storage_account" "storage" {
  for_each            = var.storage
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = each.value.account_kind

  min_tls_version                 = "TLS1_2"
  public_network_access           = "Disabled"
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled      = true

  tags = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_container" "blob" {
  for_each              = var.storage
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.storage[each.key].id
  container_access_type = each.value.container_access_type
}
