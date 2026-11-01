terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.10.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "endpoint"
    storage_account_name = "endpointstatefile"
    container_name       = "endpointcontainer"
    key                  = "dev.endpointcontainer"
  }
}

provider "azurerm" {
  features {}
}
