output "service_arn" {
  value       = var.ignore_changes ? aws_ecs_service.ignore_changes[0].id : aws_ecs_service.default[0].id
  description = "The ARN for the ECS Service"
}
