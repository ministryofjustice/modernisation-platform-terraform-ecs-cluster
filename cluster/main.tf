locals {
  ec2_capacity_provider = var.enable_ec2_capacity_provider ? {
    ec2_default = {
      instance_type               = var.ec2_capacity_instance_type
      security_group_ids          = [var.ec2_capacity_security_group_id]
      subnet_ids                  = var.ec2_subnet_ids
      associate_public_ip_address = false
      min_size                    = var.ec2_capacity_min_size
      max_size                    = var.ec2_capacity_max_size
    }
  } : {}
}

module "ecs_cluster" {
  source = "./cloudposse/ecs-cluster/aws"

  container_insights_enabled      = true
  capacity_providers_fargate      = true
  capacity_providers_fargate_spot = true
  capacity_providers_ec2          = local.ec2_capacity_provider
  context                         = module.this.context
}

