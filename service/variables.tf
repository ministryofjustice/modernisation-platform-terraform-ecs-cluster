variable "cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster"
}

variable "name" {
  type        = string
  description = "The name of the ECS service"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "container_definitions" {
  type        = string
  description = "The JSON formatted container definition"
  sensitive   = false
}

variable "ignore_changes" {
  type        = bool
  description = "Whether to ignore changes to the service, task definition, container definition"
}

variable "ignore_changes_service_task_definition" {
  type        = bool
  description = "Whether to ignore changes to the task definition attribute of the service"
}

variable "efs_volumes" {
  type        = list(map(string))
  description = "A list of EFS volumes to attach to the task definition"
  default     = []
}

variable "desired_count" {
  type        = number
  description = "The number of instances of the task definition to place and keep running"
  default     = 1
}

variable "security_groups" {
  type        = list(string)
  description = "A list of security group IDs to associate with the service"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to launch the service in"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
  default     = 100
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
  default     = 200
}

variable "enable_execute_command" {
  type        = bool
  description = "Whether to enable the execute command functionality on the service"
  default     = false
}

variable "force_new_deployment" {
  type        = bool
  description = "Whether to force a new deployment of the service"
  default     = false
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "The grace period to allow for healthy instances to warm up before checking them"
  default     = 0
}

variable "service_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for the service"
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for the task"
}

variable "task_exec_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for the execution"
}


variable "wait_for_steady_state" {
  type        = bool
  description = "Whether to wait for the service to reach a steady state before reporting success"
  default     = false
}

variable "ephemeral_storage_size_in_gib" {
  type        = number
  description = "The size of the ephemeral storage to use for the task definition"
  default     = 30
}

variable "task_cpu" {
  type        = string
  description = "The amount of CPU to use for the task definition"
  default     = "256"
}

variable "task_memory" {
  type        = string
  description = "The amount of memory to use for the task definition"
  default     = "512"
}


variable "service_load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    elb_name         = optional(string)
    target_group_arn = string
  }))
  description = "A list of load balancers to associate with the service"
}

variable "deployment_circuit_breaker" {
  type = object({
    enable   = bool
    rollback = bool
  })
  description = "The deployment circuit breaker configuration"
  default = {
    enable   = false
    rollback = false
  }
}
