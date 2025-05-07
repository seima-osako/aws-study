############################
# SNS Topic & Subscription
############################
resource "aws_sns_topic" "alert" {
  name = "${var.prefix}-alert-topic"

  tags = {
    Name = "${var.prefix}-alert-topic"
  }
}

resource "aws_sns_topic_subscription" "alert_email" {
  topic_arn = aws_sns_topic.alert.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

############################
# CloudWatch Alarm (EC2 CPU)
############################
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name          = "${var.prefix}-cpu-alarm"
  alarm_description   = "EC2 CPUUtilization threshold breached."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  datapoints_to_alarm = 1
  treat_missing_data  = "breaching"
  dimensions          = { InstanceId = var.ec2_instance_id }

  alarm_actions = [aws_sns_topic.alert.arn]
  ok_actions    = [aws_sns_topic.alert.arn]
}

############################
# WAFv2  Web ACL
############################
resource "aws_wafv2_web_acl" "alb" {
  name  = "${var.prefix}-webacl"
  scope = "REGIONAL"

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

  tags = {
    Name = "${var.prefix}-webacl"
  }
}

############################
# Web ACL ↔︎ ALB Association
############################
resource "aws_wafv2_web_acl_association" "main" {
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

resource "aws_wafv2_web_acl_logging_configuration" "main" {
  resource_arn            = aws_wafv2_web_acl.alb.arn
  log_destination_configs = [aws_cloudwatch_log_group.waf.arn]
}
