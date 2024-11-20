output "service_arn" {
  value       = aws_ecs_service.default.id
  description = "The ARN for the ECS Service"
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.default.arn
  description = "The ARN for the ECS Task Definition"
}

output "task_definition_string" {
  value       = "${aws_ecs_task_definition.default.id}:${aws_ecs_task_definition.default.revision}"
  description = "The JSON formatted container definition"
}
