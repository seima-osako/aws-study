output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  value       = aws_security_group.ec2.id
}
