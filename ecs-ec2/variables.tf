variable "instance_type" {
  description = "ECS Instance Type"
  type        = string
  default     = "t3.large"
}

variable "subnet_ids" {
  description = "Subnet IDs to use for the ECS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "user_data" {
  description = "User data to pass to the launch template"
  type        = string
}

variable "ec2_ingress_rules" {
  description = "Security group ingress rules for the cluster EC2s"
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
    cidr_blocks     = list(string)
  }))
}

variable "ec2_egress_rules" {
  description = "Security group egress rules for the cluster EC2s"
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
    cidr_blocks     = list(string)
  }))
}
