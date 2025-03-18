# modules/eventbridge/main.tf

resource "aws_cloudwatch_event_rule" "quarterly_trigger" {
  name                = "${var.project_prefix}-quarterly-saas-review"
  description         = "Triggers SaaS procurement workflow at start of each quarter"
  schedule_expression = "cron(0 0 1 1,4,7,10 ? *)"
  
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_prefix}-quarterly-trigger"
    }
  )
}

resource "aws_cloudwatch_event_target" "sfn_target" {
  rule      = aws_cloudwatch_event_rule.quarterly_trigger.name
  target_id = "${var.project_prefix}-QuarterlySaaSReview"
  arn       = var.state_machine_arn
  role_arn  = aws_iam_role.eventbridge_role.arn

  input = jsonencode({
    quarterStartDate = "#{eventTime}",
    reviewType      = "Quarterly",
    parameters = {
      notificationRecipients = var.notification_recipients,
      departmentsToReview   = var.departments_to_review,
      costThreshold        = var.cost_threshold
    }
  })
}

resource "aws_iam_role" "eventbridge_role" {
  name = "${var.project_prefix}-eventbridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy" "eventbridge_policy" {
  name = "${var.project_prefix}-eventbridge-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution"
        ]
        Resource = [
          var.state_machine_arn
        ]
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "trigger_monitor" {
  alarm_name          = "${var.project_prefix}-trigger-monitor"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name        = "ExecutionsFailed"
  namespace          = "AWS/States"
  period             = "300"
  statistic          = "Sum"
  threshold          = "1"
  alarm_description  = "Monitors for failed quarterly review trigger executions"
  alarm_actions      = [var.sns_topic_arn]

  dimensions = {
    StateMachineArn = var.state_machine_arn
  }

  tags = var.common_tags
}