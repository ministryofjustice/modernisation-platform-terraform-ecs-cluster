module "ecs_cluster" {
  #checkov:skip=CKV_AWS_79: http endpoint and http tokens configured to enable IMDSv2 by default in `local.ec2_capacity_providers`
  source = "../cloudposse/ecs-cluster/aws"

  container_insights_enabled      = true
  capacity_providers_fargate      = true
  capacity_providers_fargate_spot = true
  capacity_providers_ec2          = local.ec2_capacity_provider
  context                         = module.this.context
}

