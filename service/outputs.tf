output "service_arn" {
  value       = module.ecs_alb_service_task.service_arn
  description = "The ARN for the ECS Service"
}
