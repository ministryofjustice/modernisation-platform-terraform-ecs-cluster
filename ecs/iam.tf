resource "aws_iam_instance_profile" "ecs_ec2" {
  count = var.ec2_capacity_enabled == true ? 1 : 0
  name  = "${var.name}-ec2-cluster-instance-profile"
  role  = aws_iam_role.ecs_ec2[0].name
}

resource "aws_iam_role" "ecs_ec2" {
  count              = var.ec2_capacity_enabled == true ? 1 : 0
  name               = "${var.name}-ec2-cluster-role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}

// attach AmazonSSMManagedInstanceCore to role
resource "aws_iam_role_policy_attachment" "ec2_cluster_ssm" {
  count      = var.ec2_capacity_enabled == true ? 1 : 0
  role       = aws_iam_role.ecs_ec2[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

// attach AmazonEC2ContainerServiceforEC2Role to instance profile
resource "aws_iam_role_policy_attachment" "ec2_cluster_ecs" {
  count      = var.ec2_capacity_enabled == true ? 1 : 0
  role       = aws_iam_role.ecs_ec2[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

// attach CloudWatchAgentServerPolicy
resource "aws_iam_role_policy_attachment" "ec2_cluster_cloudwatch" {
  count      = var.ec2_capacity_enabled == true ? 1 : 0
  role       = aws_iam_role.ecs_ec2[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role" "ecs_fargate" {
  name = "ecs-task-execution-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

// attach CloudWatchAgentServerPolicy [Fargate]
resource "aws_iam_role_policy_attachment" "fargate_cluster_cloudwatch" {
  role       = aws_iam_role.ecs_fargate.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
