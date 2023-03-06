module "ecs_alb_service_task" {
  #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  #tfsec:ignore:aws-vpc-no-public-egress-sgr
  source  = "cloudposse/ecs-alb-service-task/aws"
  version = "0.67.0"

  alb_security_group             = var.alb_security_group_id
  container_definition_json      = var.container_definition_json
  ecs_cluster_arn                = var.ecs_cluster_arn
  launch_type                    = var.launch_type
  vpc_id                         = var.vpc_id
  security_group_ids             = var.security_group_ids
  subnet_ids                     = var.subnet_ids
  ignore_changes_task_definition = var.ignore_changes_task_definition
  network_mode                   = var.network_mode
  assign_public_ip               = var.assign_public_ip

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds

  desired_count                      = var.desired_count
  task_memory                        = var.task_memory
  task_cpu                           = var.task_cpu
  ephemeral_storage_size             = var.ephemeral_storage_size
  circuit_breaker_deployment_enabled = var.circuit_breaker_deployment_enabled
  circuit_breaker_rollback_enabled   = var.circuit_breaker_rollback_enabled

  bind_mount_volumes = var.bind_mount_volumes
  efs_volumes        = var.efs_volumes
  docker_volumes     = var.docker_volumes
  fsx_volumes        = var.fsx_volumes

  proxy_configuration = var.proxy_configuration

  task_exec_role_arn    = var.task_exec_role_arn != "" ? [var.task_exec_role_arn] : []
  task_exec_policy_arns = var.task_exec_policy_arns
  task_role_arn         = var.task_role_arn != "" ? [var.task_role_arn] : []
  task_policy_arns      = var.task_policy_arns
  service_role_arn      = var.service_role_arn

  ecs_load_balancers         = var.ecs_load_balancers
  use_alb_security_group     = true
  force_new_deployment       = true
  redeploy_on_apply          = true
  deployment_controller_type = "ECS"
  propagate_tags             = "SERVICE"
  context                    = module.this.context
}
