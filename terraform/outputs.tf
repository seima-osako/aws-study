# network
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

# security-groups
output "alb_sg_id" {
  description = "Security Group ID for the ALB"
  value       = module.security.alb_sg_id
}

output "ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  value       = module.security.ec2_sg_id
}

# compute
output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.ec2_id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.ec2_public_ip
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.compute.alb_arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.compute.alb_dns_name
}
