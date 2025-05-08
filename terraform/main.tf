module "network" {
  source = "./modules/network"
  prefix = var.prefix
}

module "security" {
  source     = "./modules/security"
  prefix     = var.prefix
  vpc_id     = module.network.vpc_id
  admin_cidr = var.admin_cidr
  alb_arn    = module.compute.alb_arn
}

module "compute" {
  source            = "./modules/compute"
  prefix            = var.prefix
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  alb_sg_id         = module.security.alb_sg_id
  ec2_sg_id         = module.security.ec2_sg_id
}

module "rds" {
  source        = "./modules/rds"
  prefix        = var.prefix
  vpc_id        = module.network.vpc_id
  db_subnet_ids = module.network.rds_subnet_ids
  rds_sg_id     = module.security.rds_sg_id
  ec2_sg_id     = module.security.ec2_sg_id
  db_username   = var.db_username
  db_password   = var.db_password
}
module "monitoring" {
  source          = "./modules/monitoring"
  prefix          = var.prefix
  alert_email     = var.alert_email
  ec2_instance_id = module.compute.ec2_id
  alb_arn         = module.compute.alb_arn
}
