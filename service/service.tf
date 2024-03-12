resource "aws_ecs_service" "this" {
  name = var.name

  cluster = var.cluster_arn

  task_definition = var.ignore_changes ? aws_ecs_task_definition.ignore_changes.arn : aws_ecs_task_definition.default.arn

  launch_type = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  enable_execute_command = var.enable_execute_command

  force_new_deployment = var.force_new_deployment

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.name
    container_port   = var.container_port
  }
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  iam_role = var.ecs_service_role_arn

  wait_for_steady_state = var.wait_for_steady_state

  tags = var.tags
}
