provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "resume" {
  ...
}

resource "azurerm_cdn_profile" "resume_cdn_profile" {
  ...
}

resource "azurerm_cdn_endpoint" "resume_cdn_endpoint" {
  ...
}
