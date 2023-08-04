<!-- Rename the heading when using this template -->
# modernisation-platform-terraform-ecs//cluster


<!-- Change the URL in the release badge to point towards your new repository -->
[![Releases](https://img.shields.io/github/release/ministryofjustice/terraform-ecs/all.svg?style=flat-square)](https://github.com/ministryofjustice/terraform-ecs/releases)

<!-- Add a short description of the module -->
This module is used to deploy an ECS cluster. It provides flexibility in capacity by allowing EC2 Auto Scale Group Capacity providers or Fargate with/without SPOT support.

## Usage example

<!-- Describe how to use the module -->

<!-- Change the source URL below to point towards your new repository -->
```hcl
module "ecs-cluster" {
  source = "github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//cluster"

  environment = local.environment
  name        = format("%s-new", local.application_name)
  namespace   = "Namespace"

  tags = local.tags
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
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ../cloudposse/ecs-cluster/aws | n/a |
| <a name="module_this"></a> [this](#module\_this) | ../cloudposse/label/null | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_ec2_capacity_instance_type"></a> [ec2\_capacity\_instance\_type](#input\_ec2\_capacity\_instance\_type) | EC2 instance type for capacity provider | `string` | `"t3.medium"` | no |
| <a name="input_ec2_capacity_max_size"></a> [ec2\_capacity\_max\_size](#input\_ec2\_capacity\_max\_size) | EC2 capacity provider max size | `number` | `1` | no |
| <a name="input_ec2_capacity_min_size"></a> [ec2\_capacity\_min\_size](#input\_ec2\_capacity\_min\_size) | EC2 capacity provider min size | `number` | `1` | no |
| <a name="input_ec2_capacity_security_group_id"></a> [ec2\_capacity\_security\_group\_id](#input\_ec2\_capacity\_security\_group\_id) | EC2 capacity provider security group ID | `string` | `""` | no |
| <a name="input_ec2_subnet_ids"></a> [ec2\_subnet\_ids](#input\_ec2\_subnet\_ids) | Subnet IDs for EC2 capacity provider | `list(string)` | `[]` | no |
| <a name="input_enable_ec2_capacity_provider"></a> [enable\_ec2\_capacity\_provider](#input\_enable\_ec2\_capacity\_provider) | Enable EC2 capacity provider | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | n/a | yes |
| <a name="input_metadata_http_endpoint_enabled"></a> [metadata\_http\_endpoint\_enabled](#input\_metadata\_http\_endpoint\_enabled) | Whether or not to enable metadata HTTP endpoint. Valid values are `true` or `false` | `bool` | `true` | no |
| <a name="input_metadata_http_tokens_required"></a> [metadata\_http\_tokens\_required](#input\_metadata\_http\_tokens\_required) | Whether or not to require metadata tokens. Valid values are `true` or `false` | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually used for application name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

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
