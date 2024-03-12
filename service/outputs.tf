output "service_arn" {
  value       = aws_ecs_service.this.id
  description = "The ARN for the ECS Service"
}
