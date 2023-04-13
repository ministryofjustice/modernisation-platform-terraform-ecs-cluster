variable "environment" {
  type        = string
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "name" {
  type        = string
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}

variable "enable_ec2_capacity_provider" {
  type        = bool
  default     = false
  description = "Enable EC2 capacity provider"
}

variable "ec2_capacity_instance_type" {
  default     = "t3.medium"
  type        = string
  description = "EC2 instance type for capacity provider"
}

variable "ec2_capacity_security_group_id" {
  type        = string
  description = "EC2 capacity provider security group ID"
  default     = ""
}

variable "ec2_subnet_ids" {
  description = "Subnet IDs for EC2 capacity provider"
  type        = list(string)
  default     = []
}

variable "ec2_capacity_min_size" {
  type        = number
  default     = 1
  description = "EC2 capacity provider min size"
}

variable "ec2_capacity_max_size" {
  type        = number
  default     = 1
  description = "EC2 capacity provider max size"
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Whether or not to require metadata tokens. Valid values are `true` or `false`"
}
