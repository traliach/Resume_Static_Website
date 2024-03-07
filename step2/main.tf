# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account for hosting the static website (resume)
resource "azurerm_storage_account" "resume" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }
}

# Correction for the storage account hostname
locals {
  storage_account_hostname = replace(trim(azurerm_storage_account.resume.primary_web_endpoint, "/"), "/^https:\\/\\//", "")
}

# CDN profile for improved global access and speed
resource "azurerm_cdn_profile" "resume_cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

# CDN endpoint, linking it to the storage account
resource "azurerm_cdn_endpoint" "resume_cdn_endpoint" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.resume_cdn_profile.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  origin {
    name      = "resumeOrigin"
    host_name = local.storage_account_hostname
  }
}

# Optional output for verification
output "storage_account_hostname" {
  value = local.storage_account_hostname
}
