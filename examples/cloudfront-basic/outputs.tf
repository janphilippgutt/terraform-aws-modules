output "bucket_name" {
  value = module.s3_static_site.bucket_name
}

output "bucket_regional_domain_name" {
  value = module.s3_static_site.bucket_regional_domain_name
}

output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}

output "cloudfront_domain_name" {
  value = module.cloudfront.distribution_domain_name
}