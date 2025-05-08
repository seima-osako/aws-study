variable "vpc_id" {
  description = "VPC ID to create SGs in"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "admin_cidr" {
  description = "CIDR for SSH access (e.g. your office IP)"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}
