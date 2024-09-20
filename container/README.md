<!-- Rename the heading when using this template -->

# modernisation-platform-terraform-ecs//container

<!-- Change the URL in the release badge to point towards your new repository -->
[![Releases](https://img.shields.io/github/release/ministryofjustice/terraform-ecs/all.svg?style=flat-square)](https://github.com/ministryofjustice/terraform-ecs/releases)

<!-- Add a short description of the module -->
This module creates an ECS container definition.

It takes in a number of inputs (see TFDocs below) and outputs a container definition that can be used in an ECS task
definition. It outputs the container definition as a JSON string as well as a list so that multiple containers can be
defined in a single task definition (call this module many times and concat the list outputs).

## Usage example

<!-- Describe how to use the module -->

<!-- Change the source URL below to point towards your new repository -->

```hcl
module "container_definition" {
  source                   = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//container?ref=v4.2.0"
  name                     = "my-container"
  image                    = "nginx:latest"
  memory                   = 512
  cpu                      = 256
  essential                = true
  readonly_root_filesystem = false

  environment = [
    {
      name  = "ENV_VAR"
      value = "value"
    },
    {
      name  = "ENV_VAR_2"
      value = "value"
    }
  ]

  secrets = [
    {
      name      = "SECRET_NAME
      valueFrom = "arn:aws:ssm:eu-west-2:123456789012:parameter/secret"
    },
    {
      name      = "SECRET_NAME_2"
      valueFrom = "arn:aws:ssm:eu-west-2:123456789012:parameter/secret"
    }
  ]
  port_mappings = [
    {
      containerPort = 80
      hostPort      = 80
    }
  ]
  mount_points = [
    {
      sourceVolume  = "volume"
      containerPath = "/var/www/html"
      readOnly      = false
    }
  ]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
      "awslogs-region"        = "eu-west-2"
      "awslogs-stream-prefix" = "nginx"
    }
  }
}
```

<!-- See the [examples/](examples/) folder for more information. -->

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | The command for the container | `list(string)` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units to reserve for the container | `number` | `null` | no |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | The entry point for the container | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the container | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_essential"></a> [essential](#input\_essential) | If the container is essential | `bool` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | The health check for the container | <pre>object({<br/>    command     = list(string)<br/>    interval    = number<br/>    timeout     = number<br/>    retries     = number<br/>    startPeriod = number<br/>  })</pre> | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | The image to use for the container | `string` | n/a | yes |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | The linux parameters for the container | <pre>object({<br/>    capabilities = object({<br/>      add  = list(string)<br/>      drop = list(string)<br/>    })<br/>    initProcessEnabled = bool<br/>  })</pre> | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | The log configuration for the container | <pre>object({<br/>    logDriver = string<br/>    options   = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory (in MiB) to reserve for the container | `number` | `null` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | The mount points for the container | <pre>list(object({<br/>    sourceVolume  = string<br/>    containerPath = string<br/>    readOnly      = bool<br/>  }))</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the container | `string` | n/a | yes |
| <a name="input_port_mappings"></a> [port\_mappings](#input\_port\_mappings) | The port mappings for the container | <pre>list(object({<br/>    containerPort = number<br/>    hostPort      = optional(number, null)<br/>    protocol      = string<br/>  }))</pre> | n/a | yes |
| <a name="input_readonly_root_filesystem"></a> [readonly\_root\_filesystem](#input\_readonly\_root\_filesystem) | If the container has a readonly root filesystem | `bool` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets for the container | <pre>list(object({<br/>    name      = string<br/>    valueFrom = string<br/>  }))</pre> | n/a | yes |
| <a name="input_start_timeout"></a> [start\_timeout](#input\_start\_timeout) | The start timeout for the container | `number` | `null` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | The stop timeout for the container | `number` | `null` | no |
| <a name="input_system_controls"></a> [system\_controls](#input\_system\_controls) | The system controls for the container | <pre>list(object({<br/>    namespace = string<br/>    value     = string<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_json_encoded"></a> [json\_encoded](#output\_json\_encoded) | n/a |
| <a name="output_json_encoded_list"></a> [json\_encoded\_list](#output\_json\_encoded\_list) | n/a |
<!-- END_TF_DOCS -->

<!-- Uncomment the below if this module uses tags -->

<!--
## Tags

Some of the inputs for this module are tags. All infrastructure resources must be tagged to meet the MOJ Technical Guidance on [Documenting owners of infrastructure](https://technical-guidance.service.justice.gov.uk/documentation/standards/documenting-infrastructure-owners.html).

| Name                   | Description                                                                            |  Type  |   Default    | Required |
| ---------------------- | -------------------------------------------------------------------------------------- | :----: | :----------: | :------: |
| application            |                                                                                        | string |      -       |   yes    |
| business-unit          | Area of the MOJ responsible for the service                                            | string | `mojdigital` |   yes    |
| environment-name       |                                                                                        | string |      -       |   yes    |
| infrastructure-support | The team responsible for managing the infrastructure. Should be of the form team-email | string |      -       |   yes    |
| is-production          |                                                                                        | string |   `false`    |   yes    |
| team_name              |                                                                                        | string |      -       |   yes    |
| namespace              |                                                                                        | string |      -       |   yes    |
-->

## Reading Material

<!-- Add links to external sources, e.g. Kubernetes or AWS documentation -->

- [Cloud Platform user guide](https://user-guide.cloud-platform.service.justice.gov.uk/#cloud-platform-user-guide)
