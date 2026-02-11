terraform {
    required_version = ">=1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "0ce62a2d-ba06-41fc-a3c0-823746803ef1"
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
  kubernetes_version  = 
}

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Production"
#   }
# }

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.example.kube_config_raw

#   sensitive = true
# }
