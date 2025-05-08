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
