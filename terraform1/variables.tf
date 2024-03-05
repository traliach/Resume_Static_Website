variable "location" {
  description = "The Azure region where resources will be created."
  default     = "eastus"
}

variable "storage_account_name" {
  description = "The name of the storage account for hosting the resume site."
}

variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile."
}

variable "cdn_endpoint_name" {
  description = "The name of the CDN endpoint."
}
