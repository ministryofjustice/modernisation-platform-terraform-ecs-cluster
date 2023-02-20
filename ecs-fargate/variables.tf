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

variable "ecs_auto_scale_role_name" {
  description = "The name of the ECS Auto Scale Role"
}


variable "scale_up_step" {
  description = "The number of instances to add when scaling up"
  default     = 1
}

variable "scale_down_step" {
  # scale down by 1: value should be -1
  description = "The number of instances to add when scaling down"
  default     = -1
}

variable "scale_down_cpu_threshold" {
  description = "Threshold to trigger scale down"
  default     = 10
}

variable "scale_up_cpu_threshold" {
  description = "Threshold to trigger scale up"
  default     = 85
}


variable "service_nsg" {
  description = "List of NSG IDs to attach to the ecs service"
  type        = list(string)
}

variable "container_port" {
  description = "port to expose on the container"
  type        = number
}

variable "container_name" {
  description = "name of the container"
  type        = number
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 1
}

variable "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  type        = string
}
