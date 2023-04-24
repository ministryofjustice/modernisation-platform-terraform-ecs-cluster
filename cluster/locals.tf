locals {
  ec2_capacity_provider = var.enable_ec2_capacity_provider ? {
    ec2_default = {
      instance_type                  = var.ec2_capacity_instance_type
      security_group_ids             = [var.ec2_capacity_security_group_id]
      subnet_ids                     = var.ec2_subnet_ids
      associate_public_ip_address    = false
      min_size                       = var.ec2_capacity_min_size
      max_size                       = var.ec2_capacity_max_size
      metadata_http_tokens_required  = var.metadata_http_tokens_required
      metadata_http_endpoint_enabled = var.metadata_http_endpoint_enabled
    }
  } : {}
}
