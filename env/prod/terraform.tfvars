prod-rg = {
  rg-prod = {
    rg_name  = "prod-rg-security"
    location = "CentralIndia"
  }
}

prod-vnet = {
  vnet-prod = {
    vnet_name     = "prod-vnet-security"
    location      = "CentralIndia"
    rg_name       = "prod-rg-security"
    address_space = ["10.0.0.0/16"]
  }
  vnet-prod1 = {
    vnet_name     = "prod-vnet-endpoint"
    location      = "eastus"
    rg_name       = "prod-rg-security"
    address_space = ["10.142.0.0/16"]
  }
}
prod-subnet = {
  subnet-prod = {
    subnet_name      = "prod-subnet-security"
    vnet_name        = "prod-vnet-security"
    rg_name          = "prod-rg-security"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet-prod1 = {
    subnet_name      = "AzureBastionSubnet"
    vnet_name        = "prod-vnet-security"
    rg_name          = "prod-rg-security"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet-prod2 = {
    subnet_name      = "endpoint-subnet"
    vnet_name        = "prod-vnet-endpoint"
    rg_name          = "prod-rg-security"
    address_prefixes = ["10.142.1.0/24"]
  }
}
prod-pip = {
  pip-prod = {
    pip_name = "prod-pip-security"
    location = "CentralIndia"
    rg_name  = "prod-rg-security"
  }
}
prod-bastion = {
  bastion-prod = {
    bastion_name = "prod-bestion-security"
    location     = "CentralIndia"
    rg_name      = "prod-rg-security"
    subnet_name  = "AzureBastionSubnet"
    vnet_name    = "prod-vnet-security"
    pip_name     = "prod-pip-security"
  }
}

prod-vm = {
  vm-prod = {
    vm_name         = "prod-vm-security"
    rg_name         = "prod-rg-security"
    location        = "CentralIndia"
    size            = "Standard_B2ats_v2"
    subnet_name     = "prod-subnet-security"
    vnet_name       = "prod-vnet-security"
    nic_name        = "prod-nic-security"
    secret_username = "vm-username"
    secret_password = "vm-password"

  }
}
prod-storage = {
  storage-prod = {
    name                     = "prodstorageaccount53421"
    resource_group_name      = "prod-rg-security"
    location                 = "CentralIndia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    container_name           = "prod-container-security"
    container_access_type    = "private"
  }
}
prod-peering = {
  peering-prod = {
    peering_name1      = "prod-vnet-security-to-prod-vnet-endpoint"
    peering_name2      = "prod-vnet-endpoint-to-prod-vnet-security"
    rg_name            = "prod-rg-security"
    vnet_name_security = "prod-vnet-security"
    vnet_name_endpoint = "prod-vnet-endpoint"
  }
}
prod-endpoint = {
  endpoint-prod = {
    endpoint_name                    = "prod-storage-pe"
    location                         = "eastus"
    resource_group_name              = "prod-rg-security"
    endpoint_blob_name               = "prod-storage-blob-pe"
    endpoint_subresource_names       = ["blob"]
    endpoint_dns_zone_name           = "privatelink.blob.core.windows.net"
    endpoint_dns_zone_group_name     = "prod-storage-dns-zone-group"
    endpoint_dns_zone_link_name      = "prod-storage-dns-security-link"
    endpoint_subnet_name             = "endpoint-subnet"
    endpoint_vnet_name               = "prod-vnet-endpoint"
    endpoint_storage_name            = "prodstorageaccount53421"
    endpoint_vm_vnet_name            = "prod-vnet-security"
    endpoint_dns_vnet_zone_link_name = "prod-vnet-dns-security-link"
  }
}
