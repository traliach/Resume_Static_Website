# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 4.15.0"
#     }
#   }
# }

# provider "google" {
#   project = var.project_id
#   region  = var.region
# }

# Create a storage bucket
resource "google_storage_bucket" "website_bucket" {
  name                  = var.bucket_name
  location              = var.bucket_location
  force_destroy         = true
}

# // Create a storage bucket
# resource "google_storage_bucket" "website_bucket" {
#   name          = "<bucket_name>"
#   location      = "<bucket_location>"
#   force_destroy = true

#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "404.html"
#   }
# }

// Upload files to the storage bucket
# resource "google_storage_bucket_object" "website_files" {
#   for_each = fileset("<path_to_folder_containing_files>", "**/*")

#   name   = each.value
#   bucket = google_storage_bucket.website_bucket.name
#   source = "<path_to_folder_containing_files>/${each.value}"
#   # etag   = filemd5("<path_to_folder_containing_files>/${each.value}")
# }
# // Define the provider
# provider "google" {
#   credentials = file("<path_to_service_account_key_file>")
#   project     = "<project_id>"
#   region      = "<region>"
# }

# // Create a storage bucket for the website content
# resource "google_storage_bucket" "website_bucket" {
#   name          = "<bucket_name>"
#   location      = "<bucket_location>"
#   force_destroy = true

#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "404.html"
#   }
# }

# // Upload the website content to the bucket
# resource "google_storage_bucket_object" "website_content" {
#   name   = "index.html"
#   bucket = google_storage_bucket.website_bucket.name
#   source = "<path_to_website_content>"
#   content_type = "text/html"
# }

# // Create a backend bucket for load balancing
# resource "google_compute_backend_bucket" "backend_bucket" {
#   name        = "<backend_bucket_name>"
#   bucket_name = google_storage_bucket.website_bucket.name
# }

# // Create a health check for the load balancer
# resource "google_compute_health_check" "health_check" {
#   name               = "<health_check_name>"
#   check_interval_sec = 5
#   timeout_sec        = 5
#   tcp_health_check {
#     port = 80
#   }
# }

# // Create a target pool for the load balancer
# resource "google_compute_target_pool" "target_pool" {
#   name        = "<target_pool_name>"
#   region      = "<region>"
#   health_checks = [google_compute_health_check.health_check.self_link]
#   instances   = []
# }

# // Create a forwarding rule for the load balancer
# resource "google_compute_forwarding_rule" "forwarding_rule" {
#   name                  = "<forwarding_rule_name>"
#   region                = "<region>"
#   ip_protocol           = "TCP"
#   port_range            = "80"
#   target                = google_compute_target_pool.target_pool.self_link
#   load_balancing_scheme = "EXTERNAL"
#   network_tier          = "PREMIUM"
#   ssl_certificates      = [google_compute_managed_ssl_certificate.ssl_certificate.self_link]
# }

# // Create a managed SSL certificate
# resource "google_compute_managed_ssl_certificate" "ssl_certificate" {
#   name        = "<ssl_certificate_name>"
#   description = "Managed SSL Certificate"
#   managed {
#     domains = ["<domain_name>"]
#   }
# }