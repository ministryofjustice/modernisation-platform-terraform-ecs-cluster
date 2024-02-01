output "ecs_cluster_arn" {
  value = module.ecs_cluster.arn
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.name
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.id
}

output "cluster_private_dns_namespace_arn" {
  value = aws_service_discovery_private_dns_namespace.this[0].arn
}