output "bucket_name" {
  description = "Name of the created S3 bucket"
  value = aws_s3_bucket.static_site.bucket
}

output "bucket_id" {
  description = "Id of the created S3 bucket"
  value = aws_s3_bucket.static_site.id
}

output "website_endpoint" {
  description = "Website endpoint of the static site"
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.static_site.bucket_regional_domain_name
  description = "Region-specific bucket domain name."
}
