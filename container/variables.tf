variable "name" {
  description = "The name of the container"
  type        = string
}

variable "image" {
  description = "The image to use for the container"
  type        = string
}

variable "port_mappings" {
  description = "The port mappings for the container"
  type        = list(object({
    containerPort = number
    hostPort      = optional(number, null)
    protocol      = string
  }))
}

variable "cpu" {
  description = "The number of cpu units to reserve for the container"
  type        = number
  default     = null
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the container"
  type        = number
  default     = null
}

variable "essential" {
  description = "If the container is essential"
  type        = bool
}

variable "readonly_root_filesystem" {
  description = "If the container has a readonly root filesystem"
  type        = bool
}

variable "log_configuration" {
  description = "The log configuration for the container"
  type        = object({
    logDriver = string
    options   = map(string)
  })
}

variable "secrets" {
  description = "The secrets for the container"
  type        = list(object({
    name      = string
    valueFrom = string
  }))
}

variable "environment" {
  description = "The environment for the container"
  type        = list(object({
    name  = string
    value = string
  }))
}

variable "mount_points" {
  description = "The mount points for the container"
  type        = list(object({
    sourceVolume  = string
    containerPath = string
    readOnly      = bool
  }))
}

variable "health_check" {
  description = "The health check for the container"
  type        = object({
    command     = list(string)
    interval    = number
    timeout     = number
    retries     = number
    startPeriod = number
  })
  default = null
}

variable "system_controls" {
  description = "The system controls for the container"
  type        = list(object({
    namespace = string
    value     = string
  }))
  default = null
}

variable "command" {
  description = "The command for the container"
  type        = list(string)
  default     = null
}

variable "start_timeout" {
  description = "The start timeout for the container"
  type        = number
  default     = null
}

variable "stop_timeout" {
  description = "The stop timeout for the container"
  type        = number
  default     = null
}

variable "entry_point" {
  description = "The entry point for the container"
  type        = list(string)
  default     = null
}

variable "linux_parameters" {
  description = "The linux parameters for the container"
  type        = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
    initProcessEnabled = bool
  })
  default = null
}