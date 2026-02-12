terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

resource "azurerm_resource_group" "aks" {
  name     = "rg-aks-dev"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-dev"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks-dev"
  kubernetes_version  = "1.33.0"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_dc2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "cilium"
    network_data_plane = "cilium"

  }
}

