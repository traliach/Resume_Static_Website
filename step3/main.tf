
resource "random_uuid" "random" {
}

locals {
  bucket_name = "my-resume-bucket-${random_uuid.random.result}"
  website_dir = "../my_resume"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "my_resume_resources" {
  # Project Specific
  bucket_name = local.bucket_name
  website_dir = local.website_dir
  # Provider Specific
  ## Azure
  #source                = "./providers/az/static_website"
  ## AWS
  source                = "./providers/aws/static_website"
  region                = var.region
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  ## Google
  #source                = "./providers/goog/static_website"
}

output "bucket_name" {
  value = module.my_resume_resources.bucket_name
}

output "s3_bucket_website_url" {
  value = module.my_resume_resources.s3_website_url
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

