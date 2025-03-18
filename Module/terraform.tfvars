# terraform.tfvars

aws_region = "us-west-2"
project_prefix = "saas-review"
state_machine_arn = "arn:aws:states:us-west-2:123456789012:stateMachine:SaaSReviewStateMachine"
notification_recipients = [
  "finance@company.com",
  "procurement@company.com"
]
departments_to_review = [
  "Engineering",
  "Marketing",
  "Sales"
]
cost_threshold = 5000
sns_topic_arn = "arn:aws:sns:us-west-2:123456789012:SaaSReviewNotifications"
environment = "production"