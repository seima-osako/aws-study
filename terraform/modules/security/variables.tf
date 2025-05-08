variable "admin_cidr" {
  type        = string
  description = "CIDR for SSH access (e.g. your office IP)"
}

variable "alb_arn" {
  type        = string
  description = "ARN of the Application Load Balancer"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to create SGs in"
}
