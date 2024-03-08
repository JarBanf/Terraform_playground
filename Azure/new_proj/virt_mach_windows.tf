# Create public IP address
resource "azurerm_public_ip" "public_ip_windows" {
  name                = "public_ip_windows"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "nic_windows" {
  name                = "nic-windows"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet2-public_subnet_1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.4"
    public_ip_address_id          = azurerm_public_ip.public_ip_windows.id
  }
}

# Create windows virtual machine
resource "azurerm_windows_virtual_machine" "vm_windows" {
    name                = "vm-windows"
    resource_group_name = azurerm_resource_group.resource_group.name
    location              = azurerm_resource_group.resource_group.location
    size                  = "Standard_DC1S_v3"
    admin_username = "adminuser"
    admin_password = "Password1234"
    network_interface_ids = [azurerm_network_interface.nic_windows.id]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "microsoftwindowsdesktop"
      offer = "windows-11"
      sku = "win11-21h2-pro"
      version = "latest"
    }
}