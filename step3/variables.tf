# Google Cloud Terraform variables for the project and region
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "region" {
  type        = string
  description = "The region where the resources will be created"
  default     = "us-central1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the storage bucket"
}

variable "bucket_location" {
  type        = string
  description = "The location of the storage bucket"
}