
provider "aws" {
  region = "eu-central-1"
}

module "static_site" {
  source = "../../modules/s3-static-site"

  bucket_name          = "my-static-site-test-bucket-1234567890000" # must be globally unique!
  enable_public_access = false
  index_document       = "index.html"
  error_document       = "error.html"

  tags = {
    Project = "Portfolio"
    Module  = "s3-static-site"
  }
}


