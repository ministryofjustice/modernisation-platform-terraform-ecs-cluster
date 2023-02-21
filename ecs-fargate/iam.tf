resource "aws_iam_instance_profile" "fargate_cluster" {
  name = "${var.name}-fargate-cluster-instance-profile"
  role = aws_iam_role.fargate_cluster.name
}

resource "aws_iam_role" "fargate_cluster" {
  name = "role-name-task"

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

# // attach AmazonSSMManagedInstanceCore to role
# resource "aws_iam_role_policy_attachment" "fargate_cluster_ssm" {
#   role       = aws_iam_role.fargate_cluster.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

// attach CloudWatchAgentServerPolicy
resource "aws_iam_role_policy_attachment" "fargate_cluster_cloudwatch" {
  role       = aws_iam_role.fargate_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
