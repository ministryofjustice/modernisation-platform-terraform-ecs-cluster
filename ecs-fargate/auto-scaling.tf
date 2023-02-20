resource "aws_appautoscaling_target" "this" {
  service_namespace = "ecs"
  # resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  resource_id        = aws_ecs_service.this.id
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.fargate_cluster.arn
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}
resource "aws_appautoscaling_policy" "up" {
  name              = "${var.name}-fargate-cluster-scale-up"
  service_namespace = "ecs"
  # resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  resource_id        = aws_ecs_service.this.id
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_up_cooldown
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_up_step
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}


resource "aws_appautoscaling_policy" "down" {
  name              = "${var.name}-fargate-cluster-scale-down"
  service_namespace = "ecs"
  # resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  resource_id        = aws_ecs_service.this.id
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_down_cooldown
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_down_step
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "${var.name}-fargate-cluster-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.up.arn]
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.name}-fargate-cluster-cpu-utilization-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.down.arn]
}
