output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.static_site.bucket
}

output "bucket_id" {
  description = "Id of the created S3 bucket"
  value       = aws_s3_bucket.static_site.id
}

output "website_endpoint" {
  description = "S3 static site endpoint (only when public access is enabled)"
  value       = try(aws_s3_bucket_website_configuration.static_site[0].website_endpoint, null)
}


output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.static_site.bucket_regional_domain_name
  description = "Region-specific bucket domain name."
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.static_site.arn
}