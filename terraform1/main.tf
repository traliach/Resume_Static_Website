locals {
  storage_account_hostname = replace(azurerm_storage_account.resume.primary_web_endpoint, "https://", "")
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

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

resource "azurerm_cdn_profile" "resume_cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

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
