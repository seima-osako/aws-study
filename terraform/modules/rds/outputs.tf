output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.mysql.id
}

output "db_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "db_port" {
  description = "The port on which the DB accepts connections"
  value       = aws_db_instance.mysql.port
}
