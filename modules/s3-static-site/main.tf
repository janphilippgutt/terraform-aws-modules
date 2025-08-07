resource "aws_s3_bucket" "static_site" {
    bucket = var.bucket_name

    tags = {
      Name = var.bucket_name
      Environment = var.environment
    }
}

resource "aws_s3_bucket_website_configuration" "static_site" {
    bucket = aws_s3_bucket.static_site.id

    index_document {
      suffix = var.index_document
    }

    error_document {
      key = var.error_document
    }
}

resource "aws_s3_bucket_public_access_block" "static_site" {
    bucket = aws_s3_bucket.static_site.id

    block_public_acls = !var.enable_public_access
    block_public_policy = !var.enable_public_access
    ignore_public_acls = !var.enable_public_access
    restrict_public_buckets = !var.enable_public_access
}

resource "aws_s3_bucket_policy" "static_site" {
    count  = var.enable_public_access ? 1 : 0
    bucket = aws_s3_bucket.static_site.id

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Sid = "PublicReadGetObject",
                Effect = "Allow",
                Principal = "*",
                Action = "s3:GetObject",
                Resource = "${aws_s3_bucket.static_site.arn}/*"
            }
        ]
    })
}