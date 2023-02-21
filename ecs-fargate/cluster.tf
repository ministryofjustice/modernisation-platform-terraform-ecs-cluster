resource "aws_ecs_service" "this" {
  name            = "${var.name}-ecs-service"
  cluster         = aws_ecs_cluster.this.id
  launch_type     = var.launch_type
  task_definition = var.ecs_task_definition_arn
  desired_count   = var.replicas

  network_configuration {
    security_groups = var.service_nsg
    subnets         = var.subnet_ids
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  tags = merge(
    var.tags_common,
    {
      Name = "${var.name}-ecs-service"
    }
  )
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"
}
