module "network" {
  source    = "./modules/network"

  aws_region = var.aws_region
  vpc_name   = "${var.prefix}-vpc"
}
