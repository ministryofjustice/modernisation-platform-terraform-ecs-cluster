module "ecs" {
  source        = "./ecs-ec2"
  name          = "test"
  vpc_id        = "vpc-0dc3869b3e63917be"
  subnet_ids    = ["subnet-07c0e8fbdbb8a9ab1", "subnet-09c70a0674dac35a1", "subnet-057564ed0f6e11880"]
  instance_type = "t3.large"
  key_name      = aws_key_pair.generated_key.key_name
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
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
      cidr_blocks     = []
    }
  }
  egress_rules = {
    "all" = {
      description     = "All"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = []
      cidr_blocks     = []
    }
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "test"
  public_key = tls_private_key.example.public_key_openssh
}

output "key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

resource "local_file" "key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/priv.key"
}

provider "aws" {
  region = "eu-west-2"
}
