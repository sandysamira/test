# modules/eventbridge/outputs.tf

output "event_rule_arn" {
  value       = aws_cloudwatch_event_rule.quarterly_trigger.arn
  description = "ARN of the EventBridge rule"
}

output "event_rule_name" {
  value       = aws_cloudwatch_event_rule.quarterly_trigger.name
  description = "Name of the EventBridge rule"
}

output "eventbridge_role_arn" {
  value       = aws_iam_role.eventbridge_role.arn
  description = "ARN of the IAM role used by EventBridge"
}