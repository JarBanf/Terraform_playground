resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-terraform"
  location = var.resource_group_location
}

# Create a Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "teststorage1jdbqljwdbjqh"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

# Add a index.html file to the storage account
resource "azurerm_storage_blob" "blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1>Hi from Terraform</h1>"
}