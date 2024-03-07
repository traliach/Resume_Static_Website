
variable "region" {
  type        = string
  description = "AWS region"
  default     = "no-region"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS_ACCESS_KEY_ID"
  default     = "no-aws_access_key_id"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS_SECRET_ACCESS_KEY"
  default     = "no-aws_secret_access_key"
}

# Google Cloud Terraform variables for the project and region
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "goog_region" {
  type        = string
  description = "The region where the resources will be created"
  default     = "us-central1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the storage bucket"
  default = "not_bucket_name"
}

variable "bucket_location" {
  type        = string
  description = "The location of the storage bucket"
  default     = "no_bucket_location"
}
