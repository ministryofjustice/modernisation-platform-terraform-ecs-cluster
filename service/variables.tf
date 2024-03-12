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
}

variable "container_definitions" {
  type        = string
  description = "The JSON formatted container definition"
}

variable "ignore_changes" {
  type        = bool
  description = "Whether to ignore changes to the task definition"
}

variable "efs_volumes" {
  type        = list(map(string))
  description = "A list of EFS volumes to attach to the task definition"
}

variable "desired_count" {
  type        = number
  description = "The number of instances of the task definition to place and keep running"
}

variable "security_groups" {
  type        = list(string)
  description = "A list of security group IDs to associate with the service"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to launch the service in"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
}

variable "enable_execute_command" {
  type        = bool
  description = "Whether to enable the execute command functionality on the service"
}

variable "force_new_deployment" {
  type        = bool
  description = "Whether to force a new deployment of the service"
}

variable "container_port" {
  type        = number
  description = "The port on the container to associate with the load balancer"
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "The grace period to allow for healthy instances to warm up before checking them"
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the target group to associate with the service"
}

variable "ecs_service_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for the service"
}

variable "wait_for_steady_state" {
  type        = bool
  description = "Whether to wait for the service to reach a steady state before reporting success"
}
