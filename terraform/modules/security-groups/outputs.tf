output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.app_alb.id
}

output "ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  value       = aws_security_group.app_ec2.id
}
