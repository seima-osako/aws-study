output "ec2_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "ec2_public_ip" {
  description = "Public IPv4 address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}
