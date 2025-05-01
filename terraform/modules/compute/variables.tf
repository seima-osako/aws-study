variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

# VPC in which to launch the compute resources
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

# Public subnets to deploy the ALB and EC2 into
variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB and EC2 placement"
  type        = list(string)
}

# AMI and instance type for the EC2 instance
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# SSH key pair name to allow SSH access to the EC2 instance
variable "key_name" {
  description = "Name of the EC2 Key Pair"
  type        = string
}

# Security group IDs to use for ALB and EC2
variable "alb_sg_id" {
  description = "Security Group ID to attach to the ALB"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = string
}
