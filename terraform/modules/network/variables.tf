variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (2 AZ)"
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (2 AZ)"
  type        = list(string)
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "rds_subnet_cidrs" {
  description = "List of CIDR blocks for RDS subnets (3 AZ)"
  type        = list(string)
  default     = ["10.0.32.0/25", "10.0.33.0/25", "10.0.32.128/25"]
}

variable "azs" {
  description = "List of AZs corresponding to CIDR lists"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}
