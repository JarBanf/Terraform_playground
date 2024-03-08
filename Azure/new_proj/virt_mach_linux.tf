# # Create public IP address
# resource "azurerm_public_ip" "public_ip" {
#   name                = "public_ip"
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location
#   allocation_method   = "Dynamic"
# }

# # Create network interface
# resource "azurerm_network_interface" "network_interface" {
#   name                = "nic"
#   location            = azurerm_resource_group.resource_group.location
#   resource_group_name = azurerm_resource_group.resource_group.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.public_subnet_1.id
#     private_ip_address_allocation = "Static"
#     private_ip_address            = "10.0.1.4"
#     public_ip_address_id          = azurerm_public_ip.public_ip.id
#   }
# }

# # Create TLS private key
# resource "tls_private_key" "linux_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# # Save TLS private key to file
# resource "local_file" "save_linux_key" {
#   filename = "linuxkey.pem"
#   content  = tls_private_key.linux_key.private_key_pem
# }

# # Create linux virtual machine
# resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
#   name                  = "linux-vm"
#   location              = azurerm_resource_group.resource_group.location
#   resource_group_name   = azurerm_resource_group.resource_group.name
#   size                  = "Standard_DC1S_v3"
#   admin_username        = "adminuser"
#   network_interface_ids = [azurerm_network_interface.network_interface.id]
#   user_data             = filebase64("user_data_webs.sh")

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = tls_private_key.linux_key.public_key_openssh
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts-gen2"
#     version   = "latest"
#   }
# }