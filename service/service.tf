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

  dynamic "load_balancer" {
    for_each = var.service_load_balancers
    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
    }
  }

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  iam_role = var.service_role_arn

  wait_for_steady_state = var.wait_for_steady_state

  tags = var.tags
}
