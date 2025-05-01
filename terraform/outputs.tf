output "vpc_id" {
  description = "The ID of the VPC created by the network module"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.network.private_subnet_ids
}

output "rds_subnet_ids" {
  description = "List of RDS subnet IDs"
  value       = module.network.rds_subnet_ids
}

output "db_subnet_group" {
  description = "Name of the RDS DB subnet group"
  value       = module.network.db_subnet_group
}
