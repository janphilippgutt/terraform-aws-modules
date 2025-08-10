resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = var.comment
  default_root_object = "index.html"

  origin {
    domain_name = var.bucket_domain_name
    origin_id   = "s3-origin"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100" # Cheapest (US, Canada, Europe)

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}