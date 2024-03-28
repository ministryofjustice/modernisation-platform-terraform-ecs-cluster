variable "enable_container_insights" {
  type    = bool
  default = true
}

variable "name" {
  type        = string
  description = "The name of the ECS cluster"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
