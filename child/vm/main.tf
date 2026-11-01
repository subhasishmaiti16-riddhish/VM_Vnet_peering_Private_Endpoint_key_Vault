data "azurerm_subnet" "subnet" {
  for_each             = var.vm
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

}

data "azurerm_key_vault" "keyvault" {
  name                = "second-keyvault"
  resource_group_name = "SonarQube"
}

data "azurerm_key_vault_secret" "keyvault-secret-username" {
  for_each     = var.vm
  name         = each.value.secret_username
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "keyvault-secret-password" {
  for_each     = var.vm
  name         = each.value.secret_password
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vm
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.keyvault-secret-username[each.key].value
  admin_password      = data.azurerm_key_vault_secret.keyvault-secret-password[each.key].value

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
