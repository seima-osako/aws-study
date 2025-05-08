output "cloudwatch_alarm_arn" {
  description = "ARN of the EC2 CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu.arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alert.arn
}
