provider "aws" {
  region = "ap-northeast-1"
}

variables {
  prefix                = "aws-study"
  vpc_cidr              = "10.0.0.0/16"
  availability_zones    = ["ap-northeast-1a", "ap-northeast-1c"]
  db_availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

run "vpc_validation" {
  command = plan

  assert {
    condition     = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block should be 10.0.0.0/16"
  }
}

run "subnet_validation" {
  command = plan

  assert {
    condition     = length(aws_subnet.public) == 2
    error_message = "Should create 2 public subnets"
  }

  assert {
    condition     = length(aws_subnet.private) == 2
    error_message = "Should create 2 private subnets"
  }

  assert {
    condition     = length(aws_subnet.db_private) == 3
    error_message = "Should create 3 DB private subnets"
  }
}
