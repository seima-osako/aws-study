output "db_subnet_group" {
  description = "Name of the RDS DB subnet group"
  value       = aws_db_subnet_group.main.name
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for s in aws_subnet.private : s.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for s in aws_subnet.public : s.id]
}

output "rds_subnet_ids" {
  description = "List of RDS subnet IDs"
  value       = [for s in aws_subnet.db_private : s.id]
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
