variable "subnet_count" {
  type    = number
  default = 2
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  validation {
    error_message = "At least one of the provider CIDR block is not valid"
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
  }
}

variable "ec2_instance_count" {
  type    = number
  default = 0
}


variable "ec2_instance_config_list" {

  default = []

  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure only t2.micro is used
  # 1. DONE - Map from the object to the instanct_type
  # 2. DONE - Map from the instance_type to a boolean indicating wether the value equals to t2.micro
  # 3. DONE - Check whether the list of booleans contains only true values

  # Only t2 micro instances are allowed
  validation {
    error_message = "Only t2.micro instances are allowed"
    condition = alltrue([
      for instance_config in var.ec2_instance_config_list : contains(["t2.micro"], instance_config.instance_type)
    ])
  }

  # Only ubuntu and nginx amis are used
  validation {
    error_message = "At least one of the api values provided is not supported.\nOnly 'Ubuntu' and 'nginx' ami values are allowed"
    condition = alltrue([
      for instance_config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], instance_config.ami)
    ])
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))


  # Only t2 micro instances are allowed
  validation {
    error_message = "Only t2.micro instances are allowed"
    condition = alltrue([
      for instance_config in values(var.ec2_instance_config_map) : contains(["t2.micro"], instance_config.instance_type)
    ])
  }

  # Only ubuntu and nginx amis are used
  validation {
    error_message = "At least one of the api values provided is not supported.\nOnly 'Ubuntu' and 'nginx' ami values are allowed"
    condition = alltrue([
      for instance_config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], instance_config.ami)
    ])
  }
}
