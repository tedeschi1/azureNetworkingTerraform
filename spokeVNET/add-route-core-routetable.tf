resource "azurerm_route" "example" {
  name                = "route-${var.nameofvnet}"
  resource_group_name = "rg-core-vnet-routetable"
  route_table_name    = "rt-corevnet"
  address_prefix      = var.vnet-address-space
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address    = "10.1.1.1"
}

data "azurerm_route_table" "core-vnet-routetable" {
  name                = "rt-corevnet"
  resource_group_name = "rg-core-vnet-routetable"
}

data "azurerm_resource_group" "rg-route-table" {
  name     = "rg-core-vnet-routetable"
}