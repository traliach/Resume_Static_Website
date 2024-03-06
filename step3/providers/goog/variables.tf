
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
  default = "no_project_id"
}

variable "region" {
  type        = string
  description = "The region where the resources will be created"
  default     = "us-central1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the storage bucket"
  default = "no_bucket_name"

}

variable "bucket_location" {
  type        = string
  description = "The location of the storage bucket"
  default     = "no_bucket_location"
}

# variable "path_to_folder_containing_files" {
#   type        = string
#   description = "The path to the folder containing the files to be uploaded"
# }

# variable "path_to_service_account_key_file" {
#   type        = string
#   description = "The path to the service account key file"
# }

# variable "path_to_website_content" {
#   type        = string
#   description = "The path to the website content"
# }

# variable "backend_bucket_name" {
#   type        = string
#   description = "The name of the backend bucket for load balancing"
# }

# variable "health_check_name" {
#   type        = string
#   description = "The name of the health check for the load balancer"
# }

# variable "target_pool_name" {
#   type        = string
#   description = "The name of the target pool for the load balancer"
# }

# variable "forwarding_rule_name" {
#   type        = string
#   description = "The name of the forwarding rule for the load balancer"
# }

# variable "ssl_certificate_name" {
#   type        = string
#   description = "The name of the SSL certificate"
# }

# variable "domain_name" {
#   type        = string
#   description = "The domain name for the SSL certificate"
# }