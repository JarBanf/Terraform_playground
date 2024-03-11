# Create Security Group for VM Linux
resource "azurerm_network_security_group" "sg_linux" {
  name                = "sg-linux"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.2.4/32"
    destination_address_prefix = "*"
  }
}

# Associate SG to NIC VM Linux
resource "azurerm_network_interface_security_group_association" "ass_sg_to_nic_linux" {
  network_interface_id      = azurerm_network_interface.nic_linux.id
  network_security_group_id = azurerm_network_security_group.sg_linux.id
}