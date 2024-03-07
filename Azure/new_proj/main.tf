# Create a resource group for Terraform
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Create network security group for public subnets
resource "azurerm_network_security_group" "nsg-public" {
  name                = "nsg-public"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

# Create virtual network number 1
resource "azurerm_virtual_network" "virtual_network_1" {
  name                = var.virtual_network_1_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.1.0/24"]
}

# Create Public Subnet 1
resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public_subnet_1"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network_1.name
  address_prefixes     = ["10.0.1.0/28"]
}

# Create public IP address
resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "network_interface" {
  name                = "nic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.4"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Create TLS private key
resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save TLS private key to file
resource "local_file" "save_linux_key" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linux_key.private_key_pem
}

# Create linux virtual machine
resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                  = "linux-vm"
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  size                  = "Standard_DC1S_v3"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.network_interface.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.linux_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}