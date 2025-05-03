output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.load_balancer.id
}

output "ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  value       = aws_security_group.app.id
}
