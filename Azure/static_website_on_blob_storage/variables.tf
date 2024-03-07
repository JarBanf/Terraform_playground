variable "location" {
  description = "Azure region in which to create resources."
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create resources."
}

variable "storage_account_name" {
  description = "Name of the storage account"
}

variable "source_content" {
  description = "The content of the source code to be uploaded to the storage account."
}