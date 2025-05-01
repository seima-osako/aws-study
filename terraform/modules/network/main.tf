locals {
  az_suffix = { for az in var.azs : az => substr(az, -1, 1) }
  public_map  = { for idx, az in var.azs : az => var.public_subnet_cidrs[idx]  if idx < length(var.public_subnet_cidrs) }
  private_map = { for idx, az in var.azs : az => var.private_subnet_cidrs[idx] if idx < length(var.private_subnet_cidrs) }
  rds_map     = { for idx, az in var.azs : az => var.rds_subnet_cidrs[idx]     if idx < length(var.rds_subnet_cidrs) }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = var.vpc_name }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.vpc_name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.vpc_name}-public-rtb" }
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.vpc_name}-private-rtb" }
}

resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "rds-pvt-rt" }
}

resource "aws_subnet" "public" {
  for_each                = local.public_map
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = { Name = "${var.vpc_name}-public-${local.az_suffix[each.key]}" }
}

resource "aws_subnet" "private" {
  for_each                = local.private_map
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false
  tags = { Name = "${var.vpc_name}-private-${local.az_suffix[each.key]}" }
}

resource "aws_subnet" "rds" {
  for_each                = local.rds_map
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false
  tags = { Name = "rds-pvt-subnet-${lookup({for k,idx in keys(local.rds_map) : k => idx+1}, each.key)}" }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds" {
  for_each       = aws_subnet.rds
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rds.id
}

resource "aws_db_subnet_group" "this" {
  name        = "rds-pvt-subnet-group"
  description = "RDS private subnets (3AZ)"
  subnet_ids  = [for s in aws_subnet.rds : s.id]
  tags        = { Name = "rds-pvt-subnet-group" }
}
