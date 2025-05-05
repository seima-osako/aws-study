############################
# Security‑group shells
############################

resource "aws_security_group" "app_alb" {
  name        = "${var.prefix}-app-alb-sg"
  description = "Allow HTTP from the Internet to ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-app-alb-sg"
  }
}

resource "aws_security_group" "app_ec2" {
  name        = "${var.prefix}-app-ec2-sg"
  description = "Allow SSH from admin CIDR and HTTP (8080) only from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-app-ec2-sg"
  }
}

############################
# ALB rules
############################

# Ingress : HTTP 80 from anywhere
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.app_alb.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

# Egress : allow all outbound
resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.app_alb.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

############################
# EC2 rules
############################

# Ingress : SSH 22 from admin CIDR
resource "aws_vpc_security_group_ingress_rule" "app_ssh" {
  security_group_id = aws_security_group.app_ec2.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = var.admin_cidr
}

# Ingress : HTTP 8080 from ALB SG
resource "aws_vpc_security_group_ingress_rule" "app_http" {
  security_group_id            = aws_security_group.app_ec2.id
  referenced_security_group_id = aws_security_group.app_alb.id

  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"
}

# Egress : allow all outbound
resource "aws_vpc_security_group_egress_rule" "app_all" {
  security_group_id = aws_security_group.app_ec2.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
