# Create network security group for public subnets
resource "azurerm_network_security_group" "nsg-vnet2-public" {
  name                = "nsg-vnet2-public"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

# Create virtual network number 2
resource "azurerm_virtual_network" "virtual_network_2" {
  name                = var.virtual_network_2_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.2.0/24"]
}

# Create Public Subnet 1
resource "azurerm_subnet" "vnet2-public_subnet_1" {
  name                 = "vnet2-public_subnet_1"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network_2.name
  address_prefixes     = ["10.0.2.0/28"]
}