
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

#resource "aws_s3_bucket_acl" "bucket_acl" {
#  bucket = aws_s3_bucket.bucket.id
#  acl    = "public-read"
#}

resource "aws_s3_object" "upload_objects" {
  bucket   = aws_s3_bucket.bucket.id
  for_each = fileset(var.website_dir, "**/*")
  content  = filesha256("${var.website_dir}/${each.value}")
  key      = each.value
  #acl      = "public-read"
  etag = filemd5("${var.website_dir}/${each.value}")
  content_type = lookup(
    {
      ".css"  = "text/css",
      ".html" = "text/html",
      ".js"   = "application/javascript",
      ".json" = "application/json",
      ".png"  = "image/png",
      ".svg"  = "image/svg+xml",
      ".xml"  = "application/xml",
    },
    substr(each.value, length(each.value) - 4, 5),
    "application/octet-stream"
  )
}


output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "s3_website_url" {
  description = "s3 website url of the bucket"
  value       = "https://${aws_s3_bucket.bucket.id}.s3.${aws_s3_bucket.bucket.region}.amazonaws.com/index.html"
}
