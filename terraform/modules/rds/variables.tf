variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security Group ID to attach to the RDS instance"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
}

variable "rds_sg_id" {
  description = "Security Group ID to attach to the RDS instance"
  type        = string
}
