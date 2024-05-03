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
