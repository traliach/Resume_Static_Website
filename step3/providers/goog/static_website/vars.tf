
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
  default = "no_project_id"
}

variable "goog_region" {
  type        = string
  description = "The region where the resources will be created"
  default     = "us-central1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the storage bucket"
  default     = "no_bucket_name"

}

variable "bucket_location" {
  type        = string
  description = "The location of the storage bucket"
  default     = "no_bucket_location"
}

variable "website_dir" {
  type        = string
  description = "The directory containing the website files"
}

variable "storage_class" {
  type        = string
  description = "The storage class for the storage bucket"
  default     = "STANDARD"
}