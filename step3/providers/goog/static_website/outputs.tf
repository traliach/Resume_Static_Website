output "bucket_name" {
  value = google_storage_bucket.website_bucket.name
}
output "url" {
  value = google_storage_bucket.website_bucket.url
}

output "cloud_storage_website_url" {
  description = "s3 website url of the bucket"
  value       = "https://storage.googleapis.com/${google_storage_bucket.website_bucket.name}/index.html"

}