# Security group IDs to use for ALB and EC2
variable "alb_sg_id" {
  type        = string
  description = "Security Group ID to attach to the ALB"
}

# AMI and instance type for the EC2 instance
variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

# Security group IDs to use for ALB and EC2
variable "ec2_sg_id" {
  type        = string
  description = "Security Group ID to attach to the EC2 instance"
}

# AMI and instance type for the EC2 instance
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

# SSH key pair name to allow SSH access to the EC2 instance
variable "key_name" {
  type        = string
  description = "Name of the EC2 Key Pair"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

# Public subnets to deploy the ALB and EC2 into
variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for ALB and EC2 placement"
}

# VPC in which to launch the compute resources
variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
