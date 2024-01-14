variable "vpc_name" { 
  type = string
  default = "secure_vpc"
}
variable "region" {
  default = "eu-central-1"
}
variable "alarm_actions" {
  type        = list(object({ arn = string }))
  description = "SNS topics or other actions to invoke for alarms"
  default     = []
}

variable "alarm_evaluation_minutes" {
  type        = number
  default     = 2
  description = "Number of minutes of alarm state until triggering an alarm"
}

variable "allow_overwrite" {
  type        = bool
  default     = false
  description = "Allow overwriting of existing DNS records"
}

variable "attach_certificate_domains" {
  description = "Additional existing certificates which should be attached"
  type        = list(string)
  default     = []
}

variable "certificate_types" {
  type        = list(string)
  description = "Types of certificates to look for (default: AMAZON_ISSUED)"
  default     = ["AMAZON_ISSUED"]
}

variable "create_domain_aliases" {
  description = "List of domains for which alias records should be created"
  type        = list(string)
}

variable "description" {
  description = "Human description for this load balancer"
  type        = string
}

variable "enable_stickiness" {
  type        = bool
  description = "Set to true to use a cookie for load balancer stickiness"
  default     = false
}

variable "failure_threshold" {
  type        = number
  description = "Percentage of failed requests considered an anomaly"
  default     = 5
}

variable "hosted_zone_name" {
  type        = string
  description = "Hosted zone for AWS Route53"
  default     = null
}

variable "issue_certificate_domains" {
  description = "List of domains for which certificates should be issued"
  type        = list(string)
  default     = []
}

variable "legacy_target_group_names" {
  description = "Names of legacy target groups which should be included"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name for this load balancer"
  type        = string
}

variable "primary_certificate_domain" {
  description = "Primary domain name for the load balancer certificate"
  type        = string
}

variable "security_group_name" {
  type        = string
  description = "Name for the load balancer security group; defaults to name"
  default     = null
}

variable "slow_response_threshold" {
  type        = number
  default     = 10
  description = "Response time considered extremely slow"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for this load balancer"
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}

variable "target_groups" {
  description = "Target groups to which this rule should forward"

  type = map(object({
    health_check_path = string,
    health_check_port = number,
    name              = string
  }))
}

variable "target_group_weights" {
  description = "Weight for each target group (defaults to 100)"
  type        = map(number)
  default     = {}
}

variable "validate_certificates" {
  description = "Set to false to disable validation via Route 53"
  type        = bool
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC for the ALB"
}

variable "create_iam_role" {
  description = "Flag to indicate whether an IAM Role should be created to grant the proper permissions for AWS Config"
  type        = bool
  default     = false
}

variable "iam_role_arn" {
  description = <<-DOC
    The ARN for an IAM Role AWS Config uses to make read or write requests to the delivery channel and to describe the
    AWS resources associated with the account. This is only used if create_iam_role is false.

    If you want to use an existing IAM Role, set the value of this to the ARN of the existing topic and set
    create_iam_role to false.
  DOC
  default     = null
  type        = string
}

variable "assessment_duration" {
  type        = string
  description = "The max duration of the Inspector assessment run in seconds"
  default     = "3600" # 1 hour
}

variable "assessment_event_subscription" {
  type = map(object({
    event     = string
    topic_arn = string
  }))
  description = "Configures sending notifications about a specified assessment template event to a designated SNS topic"
  default     = {}
}

variable "schedule_expression" {
  type        = string
  description = <<-DOC
    An AWS Schedule Expression to indicate how often the scheduled event shoud run.

    For more information see:
    https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
  DOC
  default     = "rate(7 days)"
}

variable "event_rule_description" {
  type        = string
  description = "A description of the CloudWatch event rule"
  default     = "Trigger an AWS Inspector Assessment"
}

variable "enabled_rules" {
  type        = list(string)
  description = <<-DOC
    A list of AWS Inspector rules that should run on a periodic basis.

    Valid values are `cve`, `cis`, `nr`, `sbp` which map to the appropriate [Inspector rule arns by region](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html).
  DOC
}