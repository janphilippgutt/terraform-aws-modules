output "distribution_id" {
  value = aws_cloudfront_distribution.this.id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "oac_id" {
  value = aws_cloudfront_origin_access_control.oac.id
}
