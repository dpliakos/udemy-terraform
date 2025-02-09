variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The size of managed EC2 instances"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only supports t2.micro and t3.micro"
  }
}

variable "ec2_volume_config" {
  description = "The size in GB and type of the root block volume attached to manged EC2 instances"

  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "my_sensitive_value" {
  type      = string
  sensitive = true
}
