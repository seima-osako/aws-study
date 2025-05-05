module "network" {
  source = "./modules/network"
  prefix = var.prefix
}

module "security" {
  source     = "./modules/security-groups"
  prefix     = var.prefix
  vpc_id     = module.network.vpc_id
  admin_cidr = var.admin_cidr
}

module "compute" {
  source            = "./modules/compute"
  prefix            = var.prefix
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  alb_sg_id = module.security.alb_sg_id
  ec2_sg_id = module.security.ec2_sg_id
}
