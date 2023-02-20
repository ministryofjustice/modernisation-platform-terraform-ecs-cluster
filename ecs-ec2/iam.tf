resource "aws_iam_instance_profile" "ec2_cluster" {
  name = "${var.name}-ec2-cluster-instance-profile"
  role = aws_iam_role.ec2_cluster.name
}

resource "aws_iam_role" "ec2_cluster" {
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
  role       = aws_iam_role.ec2_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

// attach AmazonEC2ContainerServiceforEC2Role to instance profile
resource "aws_iam_role_policy_attachment" "ec2_cluster_ecs" {
  role       = aws_iam_role.ec2_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

// attach CloudWatchAgentServerPolicy
resource "aws_iam_role_policy_attachment" "ec2_cluster_cloudwatch" {
  role       = aws_iam_role.ec2_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
