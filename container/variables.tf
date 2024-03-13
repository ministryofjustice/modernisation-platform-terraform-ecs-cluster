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
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
}

variable "cpu" {
  description = "The number of cpu units to reserve for the container"
  type        = number
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the container"
  type        = number
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
  type = object({
    logDriver = string
    options   = map(string)
  })
}

variable "secrets" {
  description = "The secrets for the container"
  type = list(object({
    name      = string
    valueFrom = string
  }))
}

variable "environment" {
  description = "The environment for the container"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "mount_points" {
  description = "The mount points for the container"
  type = list(object({
    sourceVolume  = string
    containerPath = string
    readOnly      = bool
  }))
}
