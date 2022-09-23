locals {
  prefix   = "managing-g-b-using-tf-https"
  vpc_name = "${local.prefix}-vpc"
  vpc_cidr = "10.10.0.0/16"
  common_tags = {
    Environment = "dev"
    Project     = "hands-on.cloud"
  }
  min_instance      = 2
  max_instance      = 5
}