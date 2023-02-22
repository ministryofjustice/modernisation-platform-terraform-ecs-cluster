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

variable "ingress_rules" {
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

variable "egress_rules" {
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

variable "log_retention_in_days" {
  description = "Log retention in days"
  type        = number
  default     = 30
}

variable "name" {
  description = "Cluster name"
  type        = string
}


variable "tags_common" {
  type        = map(string)
  description = "Common tags to be used by all resources"
  default = {
    "key" = "value"
  }
}

variable "key_name" {
  description = "Key name to use for the cluster EC2s"
  type        = string
  default     = ""
}

variable "desired_capacity" {
  description = "Desired capacity of the cluster"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of the cluster"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the cluster"
  type        = number
  default     = 1
}

variable "ec2_capacity_enabled" {
  description = "Enable EC2 capacity"
  type        = bool
  default     = false
}
