# outputs.tf

output "event_rule_arn" {
  value       = module.quarterly_trigger.event_rule_arn
  description = "ARN of the created EventBridge rule"
}

output "eventbridge_role_arn" {
  value       = module.quarterly_trigger.eventbridge_role_arn
  description = "ARN of the EventBridge IAM role"
}