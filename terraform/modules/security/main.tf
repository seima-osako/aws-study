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

############################
# RDS Security Group
############################
resource "aws_security_group" "rds" {
  name        = "${var.prefix}-rds-sg"
  description = "Allow MySQL from EC2 SG"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.prefix}-rds-sg"
  }
}

# Ingress : MySQL 3306 from EC2 SG
resource "aws_vpc_security_group_ingress_rule" "rds_mysql" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.app_ec2.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
}

# Egress : allow all outbound
resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

############################
# WAFv2  Web ACL
############################
resource "aws_wafv2_web_acl" "alb" {
  name  = "${var.prefix}-webacl"
  scope = "REGIONAL"
  tags = {
    Name = "${var.prefix}-webacl"
  }

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.prefix}-webacl"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

############################
# Web ACL ↔︎ ALB Association
############################
resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.alb.arn
}

############################
# CloudWatch Logs for WAF
############################
resource "aws_cloudwatch_log_group" "waf" {
  name              = "aws-waf-logs-${var.prefix}-webacl"
  retention_in_days = 1
  tags = {
    Name = "${var.prefix}-wafv2-logs"
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "alb" {
  resource_arn            = aws_wafv2_web_acl.alb.arn
  log_destination_configs = [aws_cloudwatch_log_group.waf.arn]
}
