# Define the provider and required Terraform version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.12"
}

# Configure the Azure Provider
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
  default     = "tachilledevopsdemo123" # Ensure this is unique in Azure
}

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "TachilleDevOpsDemoRG"
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile."
  default     = "TachilleDevOpsCDNProfile"
}

variable "cdn_endpoint_name" {
  description = "The name of the CDN endpoint."
  default     = "TachilleDevOpsCDNEndpoint"
}

# Create a resource group to contain all resources
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
    # Optional: Specify an error document if required
    # error_document = "error.html"
  }
}

# Correcting the storage account hostname by removing 'https://' prefix and any trailing slashes
locals {
  storage_account_hostname = replace(trim(azurerm_storage_account.resume.primary_web_endpoint, "/"), "/^https:\\/\\//", "")
}

# Create a CDN profile for improving global access and speed
resource "azurerm_cdn_profile" "resume_cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

# Create a CDN endpoint, linking it to the storage account for the resume website
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

# Optional: Output the corrected storage account hostname for verification
output "storage_account_hostname" {
  value = local.storage_account_hostname
}
