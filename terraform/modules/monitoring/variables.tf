variable "alb_arn" {
  type        = string
  description = "ARN of the Application Load Balancer"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive CloudWatch alarm notifications"
}

variable "ec2_instance_id" {
  type        = string
  description = "EC2 instance ID to monitor"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}
