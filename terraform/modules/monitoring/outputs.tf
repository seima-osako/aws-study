output "sns_topic_arn" { value = aws_sns_topic.alert.arn }
output "cloudwatch_alarm_arn" { value = aws_cloudwatch_metric_alarm.ec2_cpu.arn }
