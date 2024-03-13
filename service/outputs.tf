output "service_arn" {
  value       = var.ignore_changes ? aws_ecs_service.ignore_changes[*].id : aws_ecs_service.default[*].id
  description = "The ARN for the ECS Service"
}
