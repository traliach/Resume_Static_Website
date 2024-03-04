provider "azurerm" {
  features {}
}

# Variable declarations for easy configuration and reuse
variable "location" {
  description = "The Azure region where resources will be created."
  default     = "East US"
}

variable "storage_account_name" {
  description = "The name of the storage account for hosting the resume site."
  default     = "achilledevopsdemo123" # Ensure this is unique
}

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "AchilleDevOpsDemoRG"
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile."
  default     = "AchilleDevOpsCDNProfile"
}

variable "cdn_endpoint_name" {
  description = "The name of the CDN endpoint."
  default     = "AchilleDevOpsCDNEndpoint"
}

# Define a local value for the storage account hostname
locals {
  storage_account_hostname = replace(azurerm_storage_account.resume.primary_web_endpoint, "https://", "")
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "resume" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
    #error_document = "error.html"
  }
}


# Create a CDN profile
resource "azurerm_cdn_profile" "resume_cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

# Create a CDN endpoint
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
