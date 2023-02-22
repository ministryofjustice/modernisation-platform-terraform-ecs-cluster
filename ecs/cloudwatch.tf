resource "aws_cloudwatch_log_group" "this" {
  #checkov:skip=CKV_AWS_158:Temporarily skip KMS encryption check while logging solution is being updated
  name              = "${var.name}-ecs"
  retention_in_days = var.log_retention_in_days
  tags = merge(
    var.tags_common,
    {
      Name = "${var.name}-ecs-cloudwatch-group"
    }
  )
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "${var.name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
