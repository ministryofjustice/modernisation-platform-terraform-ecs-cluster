resource "aws_ecs_cluster" "this" {
  name = var.name
  tags = var.tags
  setting {
    name  = "containerInsights"
    value = var.enable_container_insights
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
}
