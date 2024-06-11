resource "azurerm_network_security_group" "nsg" {
  count                = var.subnet-count
  name                = "${var.nameofvnet}-nsg${count.index}"
  location            = azurerm_resource_group.rg-vnet.location
  resource_group_name = azurerm_resource_group.rg-vnet.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = cidrsubnet(var.vnet-address-space, 8, count.index)
    destination_address_prefix = "*"
  }

 tags = {
    environment = "Production"
  }

  provider = azurerm.sub1
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  count = var.subnet-count
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id

  provider = azurerm.sub1

  depends_on = [azurerm_subnet.subnets]
}