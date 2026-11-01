dev-rg = {
  rg-dev = {
    rg_name  = "dev-rg-security"
    location = "CentralIndia"
  }
}

dev-vnet = {
  vnet-dev = {
    vnet_name     = "dev-vnet-security"
    location      = "CentralIndia"
    rg_name       = "dev-rg-security"
    address_space = ["10.0.0.0/16"]
  }
  vnet-dev1 = {
    vnet_name     = "dev-vnet-endpoint"
    location      = "eastus"
    rg_name       = "dev-rg-security"
    address_space = ["10.142.0.0/16"]
  }
}
dev-subnet = {
  subnet-dev = {
    subnet_name      = "dev-subnet-security"
    vnet_name        = "dev-vnet-security"
    rg_name          = "dev-rg-security"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet-dev1 = {
    subnet_name      = "AzureBastionSubnet"
    vnet_name        = "dev-vnet-security"
    rg_name          = "dev-rg-security"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet-dev2 = {
    subnet_name      = "endpoint-subnet"
    vnet_name        = "dev-vnet-endpoint"
    rg_name          = "dev-rg-security"
    address_prefixes = ["10.142.1.0/24"]
  }
}
dev-pip = {
  pip-dev = {
    pip_name = "dev-pip-security"
    location = "CentralIndia"
    rg_name  = "dev-rg-security"
  }
}
dev-bastion = {
  bastion-dev = {
    bastion_name = "dev-bestion-security"
    location     = "CentralIndia"
    rg_name      = "dev-rg-security"
    subnet_name  = "AzureBastionSubnet"
    vnet_name    = "dev-vnet-security"
    pip_name     = "dev-pip-security"
  }
}

dev-vm = {
  vm-dev = {
    vm_name         = "dev-vm-security"
    rg_name         = "dev-rg-security"
    location        = "CentralIndia"
    size            = "Standard_B2ats_v2"
    subnet_name     = "dev-subnet-security"
    vnet_name       = "dev-vnet-security"
    nic_name        = "dev-nic-security"
    secret_username = "vm-username"
    secret_password = "vm-password"

  }
}
dev-storage = {
  storage-dev = {
    name                     = "devstorageaccount53421"
    resource_group_name      = "dev-rg-security"
    location                 = "CentralIndia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    container_name           = "dev-container-security"
    container_access_type    = "private"
  }
}
dev-peering = {
  peering-dev = {
    peering_name1      = "dev-vnet-security-to-dev-vnet-endpoint"
    peering_name2      = "dev-vnet-endpoint-to-dev-vnet-security"
    rg_name            = "dev-rg-security"
    vnet_name_security = "dev-vnet-security"
    vnet_name_endpoint = "dev-vnet-endpoint"
  }
}
dev-endpoint = {
  endpoint-dev = {
    endpoint_name                    = "dev-storage-pe"
    location                         = "eastus"
    resource_group_name              = "dev-rg-security"
    endpoint_blob_name               = "dev-storage-blob-pe"
    endpoint_subresource_names       = ["blob"]
    endpoint_dns_zone_name           = "privatelink.blob.core.windows.net"
    endpoint_dns_zone_group_name     = "dev-storage-dns-zone-group"
    endpoint_dns_zone_link_name      = "dev-storage-dns-security-link"
    endpoint_subnet_name             = "endpoint-subnet"
    endpoint_vnet_name               = "dev-vnet-endpoint"
    endpoint_storage_name            = "devstorageaccount53421"
    endpoint_vm_vnet_name            = "dev-vnet-security"
    endpoint_dns_vnet_zone_link_name = "dev-vnet-dns-security-link"
  }
}
