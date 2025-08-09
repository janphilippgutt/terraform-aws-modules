output "bucket_id" {
  value = module.static_site.bucket_name
}

output "website_endpoint" {
  value = module.static_site.website_endpoint
}