resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt"
  image_id      = jsondecode(data.aws_ssm_parameter.latest_ecs.value)["image_id"]
  instance_type = var.instance_type
  key_name      = var.key_name
  ebs_optimized = true

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.this.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_cluster.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 30
      volume_type           = "gp2"
      iops                  = 0
    }
  }

  user_data = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = merge(tomap({
      "Name" = "${var.name}-ecs-cluster"
    }), var.tags_common)
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(tomap({
      "Name" = "${var.name}-ecs-cluster"
    }), var.tags_common)
  }

  tags = merge(tomap({
    "Name" = "${var.name}-ecs-cluster-template"
  }), var.tags_common)

}
