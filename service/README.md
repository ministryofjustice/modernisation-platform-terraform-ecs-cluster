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

<!-- END_TF_DOCS -->
