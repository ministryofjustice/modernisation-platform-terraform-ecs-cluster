variable "subnet_ids" {
  description = "Subnet IDs to use for the ECS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "Value of the VPC ID"
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

variable "min_capacity" {
  description = "Minimum size of the cluster"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum size of the cluster"
  type        = number
  default     = 1
}


variable "scale_up_step" {
  description = "The number of instances to add when scaling up"
  type        = number
  default     = 1
}

variable "scale_down_step" {
  # scale down by 1: value should be -1
  description = "The number of instances to add when scaling down"
  type        = number
  default     = -1
}

variable "scale_down_cooldown" {
  description = "The number of seconds to wait before scaling down"
  type        = number
  default     = 300
}

variable "scale_up_cooldown" {
  description = "The number of seconds to wait before scaling up"
  type        = number
  default     = 300
}

variable "scale_down_cpu_threshold" {
  description = "Threshold to trigger scale down"
  type        = number
  default     = 10
}

variable "scale_up_cpu_threshold" {
  description = "Threshold to trigger scale up"
  type        = number
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
