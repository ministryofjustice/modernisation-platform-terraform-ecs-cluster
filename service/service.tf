resource "aws_ecs_service" "default" {
  name = var.name

  cluster = var.cluster_arn

  task_definition = var.pin_task_definition_revision != 0 ? "${aws_ecs_task_definition.default.arn_without_revision}:${var.pin_task_definition_revision}" : aws_ecs_task_definition.default.arn

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
  triggers = var.force_new_deployment ? {
    redeployment = plantimestamp() # force update in-place every apply that has force_new_deployment set to true
  } : {}

  dynamic "load_balancer" {
    for_each = var.service_load_balancers
    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
    }
  }

  deployment_circuit_breaker {
    enable   = var.deployment_circuit_breaker.enable
    rollback = var.deployment_circuit_breaker.rollback
  }

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  wait_for_steady_state = var.wait_for_steady_state

  tags = var.tags
}
