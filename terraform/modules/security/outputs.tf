output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.app_alb.id
}

output "ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  value       = aws_security_group.app_ec2.id
}

output "rds_sg_id" {
  description = "Security Group ID for the RDS instance"
  value       = aws_security_group.rds.id
}

output "web_acl_arn" {
  value = aws_wafv2_web_acl.alb.arn
}

output "waf_log_group_arn" {
  value = aws_cloudwatch_log_group.waf.arn
}
