output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ec2_cluster_role_arn" {
  value = var.ec2_capacity_enabled ? aws_iam_role.ecs_ec2[0].arn : null
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_fargate.arn
}
