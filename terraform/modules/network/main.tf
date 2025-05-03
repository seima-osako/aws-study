locals {
  # Creates a map where keys are Availability Zone names (e.g., "ap-northeast-1a")
  # and values are the last character of the AZ name (e.g., "a").
  # Used for creating unique resource names within each AZ.
  az_suffix = { for az in var.azs : az => substr(az, -1, 1) }

  # Creates a map associating Availability Zones with their corresponding Public Subnet CIDR blocks.
  # Keys are AZ names, values are CIDR blocks from var.public_subnet_cidrs based on index.
  # Includes a check to prevent errors if var.azs has more elements than var.public_subnet_cidrs.
  public_map  = { for idx, az in var.azs : az => var.public_subnet_cidrs[idx]  if idx < length(var.public_subnet_cidrs) }

  # Creates a map associating Availability Zones with their corresponding Private Subnet CIDR blocks.
  private_map = { for idx, az in var.azs : az => var.private_subnet_cidrs[idx] if idx < length(var.private_subnet_cidrs) }

  # Creates a map associating Availability Zones with their corresponding RDS Subnet CIDR blocks.
  rds_map     = { for idx, az in var.azs : az => var.rds_subnet_cidrs[idx]     if idx < length(var.rds_subnet_cidrs) }
}

resource "aws_vpc" "network" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.prefix}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.network.id
  tags   = { Name = "${var.prefix}-igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.network.id
  tags   = { Name = "${var.prefix}-public-rtb" }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.network.id
  tags   = { Name = "${var.prefix}-private-rtb" }
}

resource "aws_route_table" "db_private_rt" {
  vpc_id = aws_vpc.network.id
  tags   = { Name = "rds-pvt-rt" }
}

resource "aws_subnet" "public_sn" {
  for_each                = local.public_map
  vpc_id                  = aws_vpc.network.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = { Name = "${var.prefix}-public-${local.az_suffix[each.key]}" }
}

resource "aws_subnet" "private_sn" {
  for_each                = local.private_map
  vpc_id                  = aws_vpc.network.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false
  tags = { Name = "${var.prefix}-private-${local.az_suffix[each.key]}" }
}

resource "aws_subnet" "db_private_sn" {
  for_each                = local.rds_map
  vpc_id                  = aws_vpc.network.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false
  tags = { Name = "rds-pvt-subnet-${index(keys(local.rds_map), each.key) + 1}" }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public_sn
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private_sn
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_private_assoc" {
  for_each       = aws_subnet.db_private_sn
  subnet_id      = each.value.id
  route_table_id = aws_route_table.db_private_rt.id
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.prefix}-rds-subnet-group"
  description = "RDS private subnets (3AZ)"
  subnet_ids  = [for s in aws_subnet.db_private_sn : s.id]
  tags        = { Name = "${var.prefix}-rds-subnet-group" }
}
