provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "sub1"
  subscription_id = var.spokevnet-subscription-id
  tenant_id = var.tenant-id
  client_id = var.sp-client-id
  client_secret = var.sp-client-secret
  features {}
}

resource "azurerm_resource_group" "rg-vnet" {
  name     = var.nameofresourcegroup
  location = var.regionofresourcegroup

  provider = azurerm.sub1
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.nameofvnet
  location            = azurerm_resource_group.rg-vnet.location
  resource_group_name = azurerm_resource_group.rg-vnet.name
  address_space       = [var.vnet-address-space]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  provider = azurerm.sub1

  tags = {
    Application_ID = var.tags-app-id
    Application_Name = var.tags-app-name
    Business_Service = var.tags-business-service
    Charge_Code = var.tags-charge-code
  }
}

resource "azurerm_subnet" "subnets" {
  count                = var.subnet-count
  name                 = "${var.nameofvnet}-subnet${count.index}"
  resource_group_name  = var.nameofresourcegroup
  virtual_network_name = var.nameofvnet
  address_prefixes     = [cidrsubnet(var.vnet-address-space, 3, count.index)]

  provider = azurerm.sub1

  depends_on = [azurerm_virtual_network.vnet]
}

data "azurerm_virtual_network" "core-vnet" {
  name                = var.nameofcorevnet
  resource_group_name = var.nameofcorevnet-resourcegroup
}

resource "azurerm_virtual_network_peering" "core-to-spoke-vnet" {
  name                      = "core-to-${var.nameofvnet}-vnetpeering"
  resource_group_name       = var.nameofcorevnet-resourcegroup
  virtual_network_name      = data.azurerm_virtual_network.core-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  allow_virtual_network_access = true

  depends_on = [azurerm_virtual_network_peering.spoke-to-core-vnet]
}

resource "azurerm_virtual_network_peering" "spoke-to-core-vnet" {
  name                      = "${var.nameofvnet}-to-core-vnetpeering"
  resource_group_name       = var.nameofresourcegroup
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.core-vnet.id
  allow_virtual_network_access = true

  provider = azurerm.sub1

  depends_on = [azurerm_virtual_network.vnet]
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.core-vnet.id
}

