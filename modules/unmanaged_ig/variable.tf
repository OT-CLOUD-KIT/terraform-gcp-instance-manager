variable "umigs" {
  description = "List of unmanaged instance group configurations"
  type = list(object({
    name        = string
    zone        = string
    instances   = list(string)
    named_ports = list(object({ name = string, port = number }))
    description = optional(string)
  }))
}

variable "network" {
  description = "VPC network"
  type        = string
}


