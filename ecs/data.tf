data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_ssm_parameter" "latest_ecs" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}
