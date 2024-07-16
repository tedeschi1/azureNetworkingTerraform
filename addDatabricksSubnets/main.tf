provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existing-vnet-rg" {
  name     = var.name-of-vnet-resourcegroup
}

data "azurerm_virtual_network" "existing-vnet" {
  name                = var.name-of-vnet
  resource_group_name = data.azurerm_resource_group.existing-vnet-rg.name
}

resource "azurerm_subnet" "int-subnet" {
  name                 = var.int-databricks-subnet-name
  resource_group_name  = data.azurerm_resource_group.existing-vnet-rg.name
  virtual_network_name = data.azurerm_virtual_network.existing-vnet.name
  address_prefixes     = [var.int-subnet-cidr]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet" "ext-subnet" {
  name                 = var.ext-databricks-subnet-name
  resource_group_name  = data.azurerm_resource_group.existing-vnet-rg.name
  virtual_network_name = data.azurerm_virtual_network.existing-vnet.name
  address_prefixes     = [var.ext-subnet-cidr]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}
