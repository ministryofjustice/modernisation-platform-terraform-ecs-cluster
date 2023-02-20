module "ecs" {
  source        = "./ecs-ec2"
  name          = "test"
  vpc_id        = "vpc-01d7a2da8f9f1dfec"
  subnet_ids    = ["subnet-04af8bd9dbbce3310", "subnet-0131824ef5a4ece01", "subnet-01815760b71d6a619"]
  instance_type = "t3.large"
  user_data = base64encode(
    <<-EOF
    #!/bin/bash -x
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
      echo ECS_CLUSTER=test >> /etc/ecs/ecs.config
    EOF
  )
  ingress_rules = {
    "all" = {
      description     = "All"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = []
      cidr_blocks     = [
        "0.0.0.0/0"
      ]
    }
  }
  egress_rules = {
    "all" = {
      description     = "All"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = []
      cidr_blocks     = [
        "0.0.0.0/0"
      ]
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
