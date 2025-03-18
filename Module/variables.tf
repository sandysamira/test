# variables.tf

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "project_prefix" {
  type        = string
  description = "Prefix to be used for resource naming"
}

variable "state_machine_arn" {
  type        = string
  description = "ARN of the Step Function state machine"
}

variable "notification_recipients" {
  type        = list(string)
  description = "List of email addresses for notifications"
}

variable "departments_to_review" {
  type        = list(string)
  description = "List of departments for review"
}

variable "cost_threshold" {
  type        = number
  description = "Cost threshold for review flagging"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of SNS topic for notifications"
}

variable "environment" {
  type        = string
  description = "Environment name"
}