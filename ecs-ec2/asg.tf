resource "aws_autoscaling_group" "this" {
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = sort(var.subnet_ids)

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.name}-cluster-scaling-group"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags_common

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
