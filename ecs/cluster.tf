resource "aws_ecs_cluster" "this" {
  name = var.name
  setting {
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
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }

  tags = merge(
    var.tags_common,
    {
      Name = "${var.name}-capacity-provider"
    }
  )
}

