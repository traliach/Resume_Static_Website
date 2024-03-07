
provider "google" {
  project = var.project_id
  region  = var.goog_region
}

locals {
  file_extensions = {
    ".css"  = "text/css",
    ".html" = "text/html",
    ".js"   = "application/javascript",
    ".json" = "application/json",
    ".png"  = "image/png",
    ".svg"  = "image/svg+xml",
    ".xml"  = "application/xml",
    ".jpeg" = "image/jpeg",
    ".jpg"  = "image/jpeg"
  }
}

# Create a storage bucket
resource "google_storage_bucket" "website_bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  storage_class               = var.storage_class
  force_destroy               = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# upload files to cloud storage
resource "google_storage_bucket_object" "upload_file" {
  // Loop through each file in the directory
  for_each = fileset(var.website_dir, "**/*")

  // Specify the bucket to which the files will be uploaded
  bucket       = google_storage_bucket.website_bucket.name

  // Construct the object name based on the file name in the directory
  name         = each.value

  // Specify the path to the file that will be uploaded
  source       = "${var.website_dir}/${each.value}"

  // Optional: Set the storage class of the object
  storage_class = "STANDARD"

  # content_type = lookup(
  #   {
  #     ".css"  = "text/css",
  #     ".html" = "text/html",
  #     ".js"   = "application/javascript",
  #     ".json" = "application/json",
  #     ".png"  = "image/png",
  #     ".svg"  = "image/svg+xml",
  #     ".xml"  = "application/xml",
  #     ".jpeg" = "image/jpeg",
  #     ".jpg"  = "image/jpeg",
  #   },
  #   substr(each.value, length(each.value) - 4, 5),
  #   "application/octet-stream"
  # )
  content_type = lookup(
  local.file_extensions,
  regex("\\.\\w+$", each.value),
  "application/octet-stream")
}

# Make bucket public by granting allUsers READER access
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_iam_member" "bucket_viewer" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}