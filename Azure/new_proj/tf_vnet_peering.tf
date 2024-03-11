resource "azurerm_virtual_network_peering" "vnet1-vnet2" {
  name                      = "vnet1-vnet2"
  resource_group_name       = azurerm_resource_group.resource_group.name
  virtual_network_name      = azurerm_virtual_network.virtual_network_1.name
  remote_virtual_network_id = azurerm_virtual_network.virtual_network_2.id
}

resource "azurerm_virtual_network_peering" "vnet2-vnet1" {
  name                      = "vnet2-vnet1"
  resource_group_name       = azurerm_resource_group.resource_group.name
  virtual_network_name      = azurerm_virtual_network.virtual_network_2.name
  remote_virtual_network_id = azurerm_virtual_network.virtual_network_1.id
}