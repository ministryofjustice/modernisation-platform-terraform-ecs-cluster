<!-- Rename the heading when using this template -->
# modernisation-platform-terraform-ecs//cluster


<!-- Change the URL in the release badge to point towards your new repository -->
[![Releases](https://img.shields.io/github/release/ministryofjustice/terraform-ecs/all.svg?style=flat-square)](https://github.com/ministryofjustice/terraform-ecs/releases)

<!-- Add a short description of the module -->
This module is used to deploy an ECS cluster with fargate support only.

## Usage example

<!-- Describe how to use the module -->

<!-- Change the source URL below to point towards your new repository -->
```hcl
module "ecs-cluster" {
  source = "github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//cluster"
  name        = "my-ecs-cluster"
  tags = {
    "environment" = "dev"
  }
}
```

<!-- See the [examples/](examples/) folder for more information. -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | n/a | `string` | `"enabled"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECS cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
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
