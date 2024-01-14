## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | ./modules/acm-certificate | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_alias"></a> [alias](#module\_alias) | ./modules/alb-route53-alias | n/a |
| <a name="module_cloudwatch_alarms"></a> [cloudwatch\_alarms](#module\_cloudwatch\_alarms) | ./modules/alb-cloudwatch-alarms | n/a |
| <a name="module_http"></a> [http](#module\_http) | ./modules/alb-http-redirect | n/a |
| <a name="module_https"></a> [https](#module\_https) | ./modules/alb-https-forward | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | cloudposse/iam-role/aws | 0.16.2 |
| <a name="module_inspector_assessment_target_label"></a> [inspector\_assessment\_target\_label](#module\_inspector\_assessment\_target\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_inspector_assessment_template_label"></a> [inspector\_assessment\_template\_label](#module\_inspector\_assessment\_template\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_inspector_schedule_label"></a> [inspector\_schedule\_label](#module\_inspector\_schedule\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_target_group"></a> [target\_group](#module\_target\_group) | ./modules/alb-target-group | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/terraform-aws-modules/terraform-aws-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.WafWebAclLoggroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_inspector_assessment_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector_assessment_target) | resource |
| [aws_inspector_assessment_template.assessment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector_assessment_template) | resource |
| [aws_shield_protection.shield](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_protection) | resource |
| [aws_wafv2_web_acl.WafWebAcl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.WafWebAclAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.WafWebAclLogging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.start_assessment_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lb_target_group.legacy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_target_group) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | SNS topics or other actions to invoke for alarms | `list(object({ arn = string }))` | `[]` | no |
| <a name="input_alarm_evaluation_minutes"></a> [alarm\_evaluation\_minutes](#input\_alarm\_evaluation\_minutes) | Number of minutes of alarm state until triggering an alarm | `number` | `2` | no |
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | Allow overwriting of existing DNS records | `bool` | `false` | no |
| <a name="input_assessment_duration"></a> [assessment\_duration](#input\_assessment\_duration) | The max duration of the Inspector assessment run in seconds | `string` | `"3600"` | no |
| <a name="input_assessment_event_subscription"></a> [assessment\_event\_subscription](#input\_assessment\_event\_subscription) | Configures sending notifications about a specified assessment template event to a designated SNS topic | <pre>map(object({<br>    event     = string<br>    topic_arn = string<br>  }))</pre> | `{}` | no |
| <a name="input_attach_certificate_domains"></a> [attach\_certificate\_domains](#input\_attach\_certificate\_domains) | Additional existing certificates which should be attached | `list(string)` | `[]` | no |
| <a name="input_certificate_types"></a> [certificate\_types](#input\_certificate\_types) | Types of certificates to look for (default: AMAZON\_ISSUED) | `list(string)` | <pre>[<br>  "AMAZON_ISSUED"<br>]</pre> | no |
| <a name="input_create_domain_aliases"></a> [create\_domain\_aliases](#input\_create\_domain\_aliases) | List of domains for which alias records should be created | `list(string)` | n/a | yes |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Flag to indicate whether an IAM Role should be created to grant the proper permissions for AWS Config | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Human description for this load balancer | `string` | n/a | yes |
| <a name="input_enable_stickiness"></a> [enable\_stickiness](#input\_enable\_stickiness) | Set to true to use a cookie for load balancer stickiness | `bool` | `false` | no |
| <a name="input_enabled_rules"></a> [enabled\_rules](#input\_enabled\_rules) | A list of AWS Inspector rules that should run on a periodic basis.<br><br>Valid values are `cve`, `cis`, `nr`, `sbp` which map to the appropriate [Inspector rule arns by region](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html). | `list(string)` | n/a | yes |
| <a name="input_event_rule_description"></a> [event\_rule\_description](#input\_event\_rule\_description) | A description of the CloudWatch event rule | `string` | `"Trigger an AWS Inspector Assessment"` | no |
| <a name="input_failure_threshold"></a> [failure\_threshold](#input\_failure\_threshold) | Percentage of failed requests considered an anomaly | `number` | `5` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Hosted zone for AWS Route53 | `string` | `null` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN for an IAM Role AWS Config uses to make read or write requests to the delivery channel and to describe the<br>AWS resources associated with the account. This is only used if create\_iam\_role is false.<br><br>If you want to use an existing IAM Role, set the value of this to the ARN of the existing topic and set<br>create\_iam\_role to false. | `string` | `null` | no |
| <a name="input_issue_certificate_domains"></a> [issue\_certificate\_domains](#input\_issue\_certificate\_domains) | List of domains for which certificates should be issued | `list(string)` | `[]` | no |
| <a name="input_legacy_target_group_names"></a> [legacy\_target\_group\_names](#input\_legacy\_target\_group\_names) | Names of legacy target groups which should be included | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for this load balancer | `string` | n/a | yes |
| <a name="input_primary_certificate_domain"></a> [primary\_certificate\_domain](#input\_primary\_certificate\_domain) | Primary domain name for the load balancer certificate | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | An AWS Schedule Expression to indicate how often the scheduled event shoud run.<br><br>For more information see:<br>https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `"rate(7 days)"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name for the load balancer security group; defaults to name | `string` | `null` | no |
| <a name="input_slow_response_threshold"></a> [slow\_response\_threshold](#input\_slow\_response\_threshold) | Response time considered extremely slow | `number` | `10` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets for this load balancer | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to created resources | `map(string)` | `{}` | no |
| <a name="input_target_group_weights"></a> [target\_group\_weights](#input\_target\_group\_weights) | Weight for each target group (defaults to 100) | `map(number)` | `{}` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Target groups to which this rule should forward | <pre>map(object({<br>    health_check_path = string,<br>    health_check_port = number,<br>    name              = string<br>  }))</pre> | n/a | yes |
| <a name="input_validate_certificates"></a> [validate\_certificates](#input\_validate\_certificates) | Set to false to disable validation via Route 53 | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC for the ALB | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"secure_vpc"` | no |

## Outputs

No outputs.
