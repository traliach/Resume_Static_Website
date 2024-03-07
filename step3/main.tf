
provider "google" {
  project = var.project_id
  region  = var.region
}

module "my_resume_resources" {
  # source = "./providers/az/static_website"
  # source = "./providers/aws/static_website"
  source          = "./providers/goog"
  bucket_name     = var.bucket_name
  bucket_location = var.bucket_location
  project_id      = var.project_id
}

output "goog_bucket_name" {
  value = module.my_resume_resources.bucket_name
}

output "goog_bucket_url" {
  value = module.my_resume_resources.url
}

