resource "aws_ecs_cluster" "this" {
  name = var.name

  dynamic "setting" {
    count = var.enable_container_insights ? 1 : 0
    content {
      name  = "containerInsights"
      value = "enabled"
    }
    
  }

resource "aws_ecs_cluster_capacity_providers" "this" {
  count              = var.ec2_capacity_enabled ? 1 : 0
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = [aws_ecs_capacity_provider.this[0].name]
}

resource "aws_ecs_capacity_provider" "this" {
  count = var.ec2_capacity_enabled ? 1 : 0
  name  = "${var.name}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this[0].arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = var.capacity_provider_maximum_scaling_step_size
      minimum_scaling_step_size = var.capacity_provider_minimum_scaling_step_size
      status                    = var.enable_managed_scaling ? "ENABLED" : "DISABLED"
      target_capacity           = var.capacity_provider_desired_capacity
    }
  }

  tags = merge(
    var.tags_common,
    {
      Name = "${var.name}-capacity-provider"
    }
  )
}

