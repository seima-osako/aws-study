variable "db_password" {
  type        = string
  description = "Master password for the RDS instance"
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for RDS"
}

variable "db_username" {
  type        = string
  description = "Master username for the RDS instance"
}

variable "ec2_sg_id" {
  type        = string
  description = "Security Group ID to attach to the RDS instance"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

variable "rds_sg_id" {
  type        = string
  description = "Security Group ID to attach to the RDS instance"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
