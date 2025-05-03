############################
# Security‑group shells
############################

resource "aws_security_group" "load_balancer" {
  name        = "${var.prefix}-alb-sg"
  description = "Allow HTTP from the Internet to ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-alb-sg"
  }
}

resource "aws_security_group" "app" {
  name        = "${var.prefix}-ec2-sg"
  description = "Allow SSH from admin CIDR and HTTP (8080) only from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-ec2-sg"
  }
}

############################
# ALB rules
############################

# Ingress : HTTP 80 from anywhere
resource "aws_vpc_security_group_ingress_rule" "load_balancer_http_in" {
  security_group_id = aws_security_group.load_balancer.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

# Egress : allow all outbound
resource "aws_vpc_security_group_egress_rule" "load_balancer_all_out" {
  security_group_id = aws_security_group.load_balancer.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

############################
# EC2 rules
############################

# Ingress : SSH 22 from admin CIDR
resource "aws_vpc_security_group_ingress_rule" "app_ssh_in" {
  security_group_id = aws_security_group.app.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = var.admin_cidr
}

# Ingress : HTTP 8080 from ALB SG
resource "aws_vpc_security_group_ingress_rule" "app_http_in" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.load_balancer.id

  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"
}

# Egress : allow all outbound
resource "aws_vpc_security_group_egress_rule" "app_all_out" {
  security_group_id = aws_security_group.app.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
