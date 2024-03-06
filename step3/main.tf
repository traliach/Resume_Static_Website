
provider "google" {
  project = var.project_id
  region  = var.region
}

module "my_resume_resources" {
  # source = "./providers/az/static_website"
  # source = "./providers/aws/static_website"
  source          = "./providers/goog"
  # bucket_name     = providers.goog.bucket_name
  # bucket_location = providers.goog.bucket_location
  project_id      = var.project_id
}

output "bucket_name" {
  value = module.my_resume_resources.bucket_name
}

# output "bucket_location" {
#   value = module.my_resume_resources.bucket_location
# }

output "bucket_url" {
  value = module.my_resume_resources.url
}

