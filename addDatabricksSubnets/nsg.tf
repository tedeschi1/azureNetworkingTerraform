resource "azurerm_subnet_network_security_group_association" "int-subnet-nsg" {
  subnet_id                 = azurerm_subnet.int-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "ext-subnet-nsg" {
  subnet_id                 = azurerm_subnet.ext-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
