variable "admin_cidr" {
  type        = string
  description = "CIDR to allow SSH to EC2 (e.g. your fixed IP)"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive CloudWatch alarm notifications"
}

variable "ami_id" {
  type        = string
  description = "Amazon Linux 2023 (x86_64) for the EC2 instance"
  default     = "ami-05206bf8aecfc7ae6"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "db_password" {
  type        = string
  description = "Master password for the RDS instance"
  sensitive   = true
}

variable "db_username" {
  type        = string
  description = "Master username for the RDS instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
  default     = "key-test"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
  default     = "aws-study"
}
