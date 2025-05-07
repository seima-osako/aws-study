variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

########################################
# SNS / CloudWatch Alarm
########################################
variable "alert_email" {
  description = "Email address to receive CloudWatch alarm notifications"
  type        = string
}

variable "ec2_instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}

########################################
# WAF
########################################
variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}

