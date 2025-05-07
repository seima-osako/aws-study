variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "aws-study"
}

variable "admin_cidr" {
  description = "CIDR to allow SSH to EC2 (e.g. your fixed IP)"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux 2023 (x86_64) for the EC2 instance"
  type        = string
  default     = "ami-05206bf8aecfc7ae6"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "key-test"
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "alert_email" {
  description = "Email address to receive CloudWatch alarm notifications"
  type        = string
}
