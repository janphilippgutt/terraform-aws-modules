output "bucket_arn" {
  value = module.s3_static_site.bucket_arn
}

output "bucket_name" {
  value = module.s3_static_site.bucket_name
}

output "bucket_domain_name" {
  value = module.s3_static_site.bucket_regional_domain_name
}