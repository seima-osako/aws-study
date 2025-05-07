output "sns_topic_arn" { value = aws_sns_topic.alert.arn }
output "cloudwatch_alarm_arn" { value = aws_cloudwatch_metric_alarm.ec2_cpu.arn }
output "web_acl_arn" { value = aws_wafv2_web_acl.alb.arn }
output "waf_log_group_arn" { value = aws_cloudwatch_log_group.waf.arn }
