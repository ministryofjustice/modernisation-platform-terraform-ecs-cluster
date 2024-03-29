module "unit_test" {
  #checkov:skip=CKV_TF_1:Module registry does not support commit hashes for versions
  source = "github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//cluster"

  ec2_capacity_instance_type     = "t3.micro"
  ec2_capacity_max_size          = "1"
  ec2_capacity_min_size          = "2"
  ec2_capacity_security_group_id = aws_security_group.unit_test.id
  ec2_subnet_ids = [
    data.aws_subnet.private_subnets_a.id,
    data.aws_subnet.private_subnets_b.id,
    data.aws_subnet.private_subnets_c.id
  ]
  environment = local.environment
  name        = "unit-test"
  namespace   = "namespace"

  tags = local.tags
}

resource "aws_security_group" "unit_test" {
  #checkov:skip=CKV2_AWS_5: "This will be attached to unit_test module
  name_prefix = "ecs-cluster-unit-test"
  vpc_id      = data.aws_vpc.shared.id
  description = "unit_test security group"
}
