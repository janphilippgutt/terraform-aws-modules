data "aws_caller_identity" "current" {}

# Create Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always" # sign requests
  signing_protocol                  = "sigv4"
}

locals {
  origin_id = "s3-${var.bucket_name}"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = var.comment
  default_root_object = var.default_root_object
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    domain_name              = var.bucket_domain_name
    origin_id                = local.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    # no s3_origin_config needed when using OAC
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  price_class = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Build the distribution ARN for the bucket policy condition
locals {
  distribution_arn = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.this.id}"
}

# S3 bucket policy allowing CloudFront (service principal) only for this distribution
data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    sid = "AllowCloudFrontServicePrincipalReadOnly"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = [
      "${var.bucket_arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [local.distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "for_cloudfront" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
}
