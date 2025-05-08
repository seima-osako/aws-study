variable "azs" {
  type        = list(string)
  description = "List of AZs corresponding to CIDR lists"
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets (2 AZ)"
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets (2 AZ)"
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "rds_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for RDS subnets (3 AZ)"
  default     = ["10.0.32.0/25", "10.0.33.0/25", "10.0.32.128/25"]
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}
