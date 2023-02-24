#module "ecs" {
#  source        = "./ecs"
#  name          = "test"
#  vpc_id        = "vpc-01d7a2da8f9f1dfec"
#  subnet_ids    = ["subnet-04af8bd9dbbce3310", "subnet-0131824ef5a4ece01", "subnet-01815760b71d6a619"]
#  instance_type = "t3.large"
#  user_data = base64encode(
#    <<-EOF
#    #!/bin/bash -x
#    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
#      echo ECS_CLUSTER=test >> /etc/ecs/ecs.config
#    EOF
#  )
#  ingress_rules = {
#    "all" = {
#      description     = "All"
#      from_port       = 0
#      to_port         = 0
#      protocol        = "-1"
#      security_groups = []
#      cidr_blocks = [
#        "0.0.0.0/0"
#      ]
#    }
#  }
#  egress_rules = {
#    "all" = {
#      description     = "All"
#      from_port       = 0
#      to_port         = 0
#      protocol        = "-1"
#      security_groups = []
#      cidr_blocks = [
#        "0.0.0.0/0"
#      ]
#    }
#  }
#}

data "aws_subnet" "private_subnets_a" {
  vpc_id = "vpc-01d7a2da8f9f1dfec"
  tags = {
    "Name" = "hmpps-development-general-private-eu-west-2a"
  }
}

data "aws_subnet" "private_subnets_b" {
  vpc_id = "vpc-01d7a2da8f9f1dfec"
  tags = {
    "Name" = "hmpps-development-general-private-eu-west-2b"
  }
}

data "aws_subnet" "private_subnets_c" {
  vpc_id = "vpc-01d7a2da8f9f1dfec"
  tags = {
    "Name" = "hmpps-development-general-private-eu-west-2c"
  }
}

module "ecs" {
  source = "./ecs"
  name = "test-jitbit"
  enable_ec2_capacity_provider = true
  ec2_capacity_security_group_id = "sg-039641b55accdef23"
  ec2_subnet_ids = [
    data.aws_subnet.private_subnets_a.id,
    data.aws_subnet.private_subnets_b.id,
    data.aws_subnet.private_subnets_c.id
  ]
}

provider "aws" {
  region = "eu-west-2"
}
