locals {
  create_task_role = length(var.task_role_arn) == 0
}

data "aws_iam_policy_document" "ecs_task" {
  count = local.create_task_role ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task" {
  count = local.create_task_role ? 1 : 0

  name                 = format("%s-task-role", var.name)
  assume_role_policy   = join("", data.aws_iam_policy_document.ecs_task.*.json)
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
  tags                 = var.tags_common
}

resource "aws_iam_role_policy_attachment" "ecs_task" {
  for_each   = local.create_task_role ? toset(var.task_policy_arns) : toset([])
  policy_arn = each.value
  role       = join("", aws_iam_role.ecs_task.*.id)
}

data "aws_iam_policy_document" "ecs_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_service" {
  count                = local.enable_ecs_service_role && var.service_role_arn == null ? 1 : 0
  name                 = format("%s-service-role", var.name)
  assume_role_policy   = join("", data.aws_iam_policy_document.ecs_service.*.json)
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
  tags                 = var.tags_common
}

data "aws_iam_policy_document" "ecs_service_policy" {
  count = local.enable_ecs_service_role && var.service_role_arn == null ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service" {
  count  = local.enable_ecs_service_role && var.service_role_arn == null ? 1 : 0
  name   = format("%s-service-role-policy", var.name)
  policy = join("", data.aws_iam_policy_document.ecs_service_policy.*.json)
  role   = join("", aws_iam_role.ecs_service.*.id)
}
