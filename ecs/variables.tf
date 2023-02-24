variable "enable_ec2_capacity_provider" {
  type = bool
  default = false
  description = "Enable EC2 capacity provider"
}

variable "ec2_capacity_instance_type" {
  default = "t3.medium"
  type = string
  description = "EC2 instance type for capacity provider"
}

variable "ec2_capacity_security_group_id" {
  type = string
  description = "EC2 capacity provider security group ID"
  default = ""
}

variable "ec2_subnet_ids" {
  description = "Subnet IDs for EC2 capacity provider"
  type        = list(string)
  default = []
}

variable "ec2_capacity_min_size" {
  type = number
  default = 1
  description = "EC2 capacity provider min size"
}

variable "ec2_capacity_max_size" {
    type = number
    default = 1
    description = "EC2 capacity provider max size"
}