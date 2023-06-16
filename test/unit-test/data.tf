data "aws_vpc" "shared" {
  tags = {
    "Name" = "${var.networking[0].business-unit}-${local.environment}"
  }
}

data "aws_subnet" "private_subnets_a" {
  vpc_id = data.aws_vpc.shared.id
  filter {
    name   = "tag:Name"
    values = ["*platforms-test-general-private-eu-west-2a*"]
  }
}

data "aws_subnet" "private_subnets_b" {
  vpc_id = data.aws_vpc.shared.id
  filter {
    name   = "tag:Name"
    values = ["*platforms-test-general-private-eu-west-2b*"]
  }
}

data "aws_subnet" "private_subnets_c" {
  vpc_id = data.aws_vpc.shared.id
  filter {
    name   = "tag:Name"
    values = ["*platforms-test-general-private-eu-west-2c*"]
  }
}