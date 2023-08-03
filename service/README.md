<!-- Rename the heading when using this template -->
# modernisation-platform-terraform-ecs//service


<!-- Change the URL in the release badge to point towards your new repository -->
[![Releases](https://img.shields.io/github/release/ministryofjustice/terraform-ecs/all.svg?style=flat-square)](https://github.com/ministryofjustice/terraform-ecs/releases)

<!-- Add a short description of the module -->
This module is used to deploy an ECS Service and/or task definitions onto an ECS Cluster.
## Usage example

<!-- Describe how to use the module -->

<!-- Change the source URL below to point towards your new repository -->
```hcl
module "service" {
  source                    = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//service"
  
  container_definition_json = module.container.json_map_encoded_list
  ecs_cluster_arn           = "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${var.environment}-${local.app_name}"
  name                      = local.app_name
  vpc_id                    = var.vpc_id

  launch_type  = "FARGATE"
  network_mode = "awsvpc"

  task_cpu    = "1024"
  task_memory = "3072"

  task_exec_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.app_name}-ecs-task-execution-role"

  environment = var.environment
  ecs_load_balancers = [
    {
      target_group_arn = "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:targetgroup/tg-name/xxxxxxxxxx"
      container_name   = local.app_name
      container_port   = 5000
    }
  ]

  security_group_ids    = ["sg-xxxxxxxxxxxxxx"]
  alb_security_group_id = "sg-xxxxxxxxxxxxxx"

  subnet_ids = [
    data.aws_subnet.private_subnets_a.id,
    data.aws_subnet.private_subnets_b.id,
    data.aws_subnet.private_subnets_c.id
  ]

  ignore_changes_task_definition = false
}
```

<!-- See the [examples/](examples/) folder for more information. -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_alb_service_task"></a> [ecs\_alb\_service\_task](#module\_ecs\_alb\_service\_task) | ../cloudposse/ecs-alb-service-task/aws | n/a |
| <a name="module_this"></a> [this](#module\_this) | ../cloudposse/label/null | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | Security group of the ALB | `string` | `""` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP address to the ENI (Fargate launch type only). Valid values are `true` or `false`. Default `false` | `bool` | `false` | no |
| <a name="input_bind_mount_volumes"></a> [bind\_mount\_volumes](#input\_bind\_mount\_volumes) | Task bind mount volume definitions as list of configuration objects. You can define multiple bind mount volumes on the same task definition. Requires `name` and optionally `host_path` | `list(any)` | `[]` | no |
| <a name="input_circuit_breaker_deployment_enabled"></a> [circuit\_breaker\_deployment\_enabled](#input\_circuit\_breaker\_deployment\_enabled) | If `true`, enable the deployment circuit breaker logic for the service. If using `CODE_DEPLOY` for `deployment_controller_type`, this value will be ignored | `bool` | `false` | no |
| <a name="input_circuit_breaker_rollback_enabled"></a> [circuit\_breaker\_rollback\_enabled](#input\_circuit\_breaker\_rollback\_enabled) | If `true`, Amazon ECS will roll back the service if a service deployment fails. If using `CODE_DEPLOY` for `deployment_controller_type`, this value will be ignored | `bool` | `false` | no |
| <a name="input_container_definition_json"></a> [container\_definition\_json](#input\_container\_definition\_json) | A string containing a JSON-encoded array of container definitions<br>(`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).<br>See [API\_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),<br>[cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or<br>[ecs\_task\_definition#container\_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions) | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": "hmpps",<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_docker_volumes"></a> [docker\_volumes](#input\_docker\_volumes) | Task docker volume definitions as list of configuration objects. You can define multiple Docker volumes on the same task definition, but a single volume can only have one `docker_volume_configuration`. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| <a name="input_ecs_load_balancers"></a> [ecs\_load\_balancers](#input\_ecs\_load\_balancers) | A list of load balancer config objects for the ECS service; see [ecs\_service#load\_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#load_balancer) docs | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    elb_name         = optional(string, "")<br>    target_group_arn = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | Task EFS volume definitions as list of configuration objects. You can define multiple EFS volumes on the same task definition, but a single volume can only have one `efs_volume_configuration`. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = optional(string, "ENABLED")<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | n/a | yes |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | The number of GBs to provision for ephemeral storage on Fargate tasks. Must be greater than or equal to 21 and less than or equal to 200 | `number` | `0` | no |
| <a name="input_exec_enabled"></a> [exec\_enabled](#input\_exec\_enabled) | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Enable to force a new task deployment of the service. | `bool` | `false` | no |
| <a name="input_fsx_volumes"></a> [fsx\_volumes](#input\_fsx\_volumes) | Task FSx volume definitions as list of configuration objects. You can define multiple FSx volumes on the same task definition, but a single volume can only have one `fsx_windows_file_server_volume_configuration`. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    fsx_windows_file_server_volume_configuration = list(object({<br>      file_system_id = string<br>      root_directory = string<br>      authorization_config = list(object({<br>        credentials_parameter = string<br>        domain                = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers | `number` | `0` | no |
| <a name="input_ignore_changes_task_definition"></a> [ignore\_changes\_task\_definition](#input\_ignore\_changes\_task\_definition) | Whether to ignore changes in container definition and task definition in the ECS service | `bool` | `true` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"FARGATE"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type` | `string` | `"awsvpc"` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| <a name="input_redeploy_on_apply"></a> [redeploy\_on\_apply](#input\_redeploy\_on\_apply) | Updates the service to the latest task definition on each apply | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs to allow in Service `network_configuration` if `var.network_mode = "awsvpc"` | `list(string)` | `[]` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs used in Service `network_configuration` if `var.network_mode = "awsvpc"` | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match [supported memory values](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `256` | no |
| <a name="input_task_exec_policy_arns"></a> [task\_exec\_policy\_arns](#input\_task\_exec\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task execution role. | `list(string)` | `[]` | no |
| <a name="input_task_exec_role_arn"></a> [task\_exec\_role\_arn](#input\_task\_exec\_role\_arn) | IAM Role arn that allows the ECS/Fargate agent to make calls to the ECS API on your behalf. If not provided, a role will be created for you. | `string` | `""` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match [supported cpu value](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `512` | no |
| <a name="input_task_policy_arns"></a> [task\_policy\_arns](#input\_task\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task role. | `list(string)` | `[]` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services. If not provided, a role will be created for you. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources are created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The ARN for the ECS Service |
<!-- END_TF_DOCS -->