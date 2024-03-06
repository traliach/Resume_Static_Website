output "bucket_name" {
  value = google_storage_bucket.website_bucket.name
}
output "url" {
  value = google_storage_bucket.website_bucket.url
}
