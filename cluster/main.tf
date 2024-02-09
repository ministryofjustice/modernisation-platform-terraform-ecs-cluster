module "ecs_cluster" {
  #checkov:skip=CKV_AWS_79: http endpoint and http tokens configured to enable IMDSv2 by default in `local.ec2_capacity_provider`
  source = "../cloudposse/ecs-cluster/aws"

  container_insights_enabled      = true
  capacity_providers_fargate      = true
  capacity_providers_fargate_spot = true
  capacity_providers_ec2          = local.ec2_capacity_provider
  context                         = module.this.context
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  count       = var.private_dns_namespace_enabled ? 1 : 0
  name        = "${var.namespace}.${var.environment}.cluster"
  description = "Namespace for ${var.namespace}.${var.environment}.cluster"
  vpc         = var.vpc_id
  tags        = var.tags
}
