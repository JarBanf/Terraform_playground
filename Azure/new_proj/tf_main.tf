# Create a resource group for Terraform
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}