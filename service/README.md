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
module "ecs_service" {
  source                = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//service"

  container_definitions = module.container_definition.json_map_encoded_list
  cluster_arn           = var.ecs_cluster_arn
  name                  = var.name

  task_cpu    = var.container_cpu
  task_memory = var.container_memory

  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  service_role_arn   = "arn:aws:iam::${var.account_info.id}:role/${module.ecs_policies.service_role.name}"
  task_role_arn      = "arn:aws:iam::${var.account_info.id}:role/${module.ecs_policies.task_role.name}"
  task_exec_role_arn = "arn:aws:iam::${var.account_info.id}:role/${module.ecs_policies.task_exec_role.name}"

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  service_load_balancers = [
    {
      target_group_arn = aws_lb_target_group.frontend.arn
      container_name   = var.name
      container_port   = var.container_port_config[0].containerPort
    }
  ]

  efs_volumes = var.efs_volumes

  security_groups = [aws_security_group.ecs_service.id]

  subnets = var.account_config.private_subnet_ids

  enable_execute_command = true

  ignore_changes = false

  tags = var.tags
}

```

<!-- See the [examples/](examples/) folder for more information. -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.ignore_changes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.ignore_changes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | The ARN of the ECS cluster | `string` | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | The JSON formatted container definition | `string` | n/a | yes |
| <a name="input_deployment_circuit_breaker"></a> [deployment\_circuit\_breaker](#input\_deployment\_circuit\_breaker) | The deployment circuit breaker configuration | <pre>object({<br>    enable   = bool<br>    rollback = bool<br>  })</pre> | <pre>{<br>  "enable": false,<br>  "rollback": false<br>}</pre> | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | n/a | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Whether to enable the execute command functionality on the service | `bool` | `false` | no |
| <a name="input_ephemeral_storage_size_in_gib"></a> [ephemeral\_storage\_size\_in\_gib](#input\_ephemeral\_storage\_size\_in\_gib) | The size of the ephemeral storage to use for the task definition | `number` | `30` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Whether to force a new deployment of the service | `bool` | `false` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | The grace period to allow for healthy instances to warm up before checking them | `number` | `0` | no |
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | Whether to ignore changes to the service, task definition, container definition | `bool` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECS service | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to associate with the service | `list(string)` | n/a | yes |
| <a name="input_service_load_balancers"></a> [service\_load\_balancers](#input\_service\_load\_balancers) | A list of load balancers to associate with the service | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    elb_name         = optional(string)<br>    target_group_arn = string<br>  }))</pre> | n/a | yes |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | The ARN of the IAM role to use for the service | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to launch the service in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The amount of CPU to use for the task definition | `string` | `"256"` | no |
| <a name="input_task_exec_role_arn"></a> [task\_exec\_role\_arn](#input\_task\_exec\_role\_arn) | The ARN of the IAM role to use for the execution | `string` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory to use for the task definition | `string` | `"512"` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The ARN of the IAM role to use for the task | `string` | n/a | yes |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | Whether to wait for the service to reach a steady state before reporting success | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The ARN for the ECS Service |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | The ARN for the ECS Task Definition |
| <a name="output_task_definition_string"></a> [task\_definition\_string](#output\_task\_definition\_string) | The JSON formatted container definition |
<!-- END_TF_DOCS -->
