resource "iam_instance_profile" "ec2_cluster" {
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
