data "azurerm_network_watcher" "existing" {
  name                = "NetworkWatcher_eastus"
  resource_group_name = "NetworkWatcherRG"
}

data "azurerm_storage_account" "existing" {
  name                = "stoageazuredevops"
  resource_group_name = "rg-azuredevops"

  provider = azurerm.sub1
}

resource "azurerm_network_watcher_flow_log" "test" {
  network_watcher_name = data.azurerm_network_watcher.existing.name
  resource_group_name  = "NetworkWatcherRG"
  name                 = "${var.nameofvnet}-nsgflowlog${count.index}"
  count                = var.subnet-count
  
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
  storage_account_id        = data.azurerm_storage_account.existing.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }

  provider = azurerm.sub1
}