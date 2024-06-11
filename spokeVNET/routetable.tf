resource "azurerm_route_table" "routetable" {
  name                = "routetable1"
  location            = azurerm_resource_group.rg-vnet.location
  resource_group_name = azurerm_resource_group.rg-vnet.name

  route {
    name                   = "example"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }

  provider = azurerm.sub1
}

resource "azurerm_subnet_route_table_association" "rt-association" {
  count = var.subnet-count
  subnet_id      = azurerm_subnet.subnets[count.index].id
  route_table_id = azurerm_route_table.routetable.id

  provider = azurerm.sub1

  depends_on = [azurerm_subnet.subnets]
}