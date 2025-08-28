module "frontend_ecr" {
  source = "../../modules/ecr"
  name   = "frontend"
  scan_on_push = true
  max_image_count = 10
}

module "api_ecr" {
  source = "../../modules/ecr"
  name   = "api"
  scan_on_push = true
  max_image_count = 10
}