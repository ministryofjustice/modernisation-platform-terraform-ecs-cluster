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
  source                         = "./ecs"
  name                           = "test-jitbit"
  enable_ec2_capacity_provider   = true
  ec2_capacity_security_group_id = "sg-039641b55accdef23"
  ec2_subnet_ids = [
    data.aws_subnet.private_subnets_a.id,
    data.aws_subnet.private_subnets_b.id,
    data.aws_subnet.private_subnets_c.id
  ]
}

module "container" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=tags/0.58.1"
  container_name           = "hello-service"
  container_image          = "public.ecr.aws/poc-hello-world/hello-service:latest"
  container_memory         = "512"
  container_cpu            = "256"
  essential                = true
  readonly_root_filesystem = false
  environment = [{
    name  = "AppURL"
    value = "https://delius-jitbit.hmpps-development.modernisation-platform.service.justice.gov.uk/"
  }]
  port_mappings = [{
    containerPort = 3000
    hostPort      = 3000
    protocol      = "tcp"
  }]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = "delius-jitbit-ecs"
      "awslogs-region"        = "eu-west-2"
      "awslogs-stream-prefix" = "jitbit"
    }
  }
  # secrets = [
  #   {
  #     name      = "ConnectionStrings__DBConnectionString"
  #     valueFrom = "arn:aws:secretsmanager:eu-west-2:142262177450:secret:delius-jitbit-app-connection-string-xMnuvx"
  #   },
  #   {
  #     name      = "S3_User_Key"
  #     valueFrom = "arn:aws:secretsmanager:eu-west-2:142262177450:secret:delius-jitbit-s3-user-access-key-*"
  #   },
  #   {
  #     name      = "S3_User_Secret"
  #     valueFrom = "arn:aws:secretsmanager:eu-west-2:142262177450:secret:delius-jitbit-s3-user-secret-key-*"
  #   }
  # ]
}

resource "aws_security_group" "load_balancer_security_group" {
  name_prefix = "test-loadbalancer-security-group"
  description = "controls access to lb"
  vpc_id      = "vpc-01d7a2da8f9f1dfec"

  ingress {
    protocol    = "tcp"
    description = "Allow ingress from white listed CIDRs"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["81.134.202.29/32", ]
  }

  egress {
    protocol    = "tcp"
    description = "Allow egress to ECS instances"
    from_port   = 3000
    to_port     = 3000
    cidr_blocks = [data.aws_subnet.private_subnets_a.cidr_block, data.aws_subnet.private_subnets_b.cidr_block, data.aws_subnet.private_subnets_c.cidr_block]
  }

  tags = merge(
    {
      Name = "test-loadbalancer-security-group"
    }
  )
}

module "ecs_alb_service_task" {
  source                             = "cloudposse/ecs-alb-service-task/aws"
  alb_security_group                 = aws_security_group.load_balancer_security_group.id
  container_definition_json          = module.container.json_map_encoded_list
  ecs_cluster_arn                    = module.ecs.ecs_cluster_arn
  launch_type                        = "FARGATE"
  vpc_id                             = "vpc-01d7a2da8f9f1dfec"
  security_group_ids                 = []
  subnet_ids                         = [data.aws_subnet.private_subnets_a.id, data.aws_subnet.private_subnets_b.id, data.aws_subnet.private_subnets_c.id]
  ignore_changes_task_definition     = false
  network_mode                       = "awsvpc"
  assign_public_ip                   = false
  propagate_tags                     = "NONE"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 1
  task_memory                        = "4096"
  task_cpu                           = "2048"
  ecs_service_enabled                = true

  context = module.this.context
}

provider "aws" {
  region = "eu-west-2"
}
