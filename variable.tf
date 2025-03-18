# modules/eventbridge/variables.tf

variable "project_prefix" {
  type        = string
  description = "Prefix to be used for resource naming"
}

variable "state_machine_arn" {
  type        = string
  description = "ARN of the Step Function state machine to trigger"
}

variable "notification_recipients" {
  type        = list(string)
  description = "List of email addresses to receive notifications"
}

variable "departments_to_review" {
  type        = list(string)
  description = "List of departments to include in the review"
}

variable "cost_threshold" {
  type        = number
  description = "Cost threshold for review flagging"
  default     = 5000
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of SNS topic for alarm notifications"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to be applied to all resources"
  default     = {}
}