variable "region" {
  description = "The default project ID where resource will be created"
  type        = string
}

variable "name" {
  description = "Base name used for naming resources like templates or instance groups"
  type        = string
}

variable "migs" {
  description = "List of managed instance group configurations"
  type = list(object({
    name                   = string
    target_size            = number
    named_ports            = list(object({ name = string, port = number }))
    enable_auto_healing    = bool
    auto_healing_delay     = optional(number)
    health_check           = optional(string)
    enable_autoscaling     = bool
    min_replicas           = optional(number)
    max_replicas           = optional(number)
    target_cpu_utilization = optional(number)
  }))
}

# Template-related inputs
variable "machine_type" {
  description = "Machine type"
  type        = string
}

variable "source_image" {
  description = "Source image for the boot disk"
  type        = string
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-balanced"
}

variable "boot_disk_size_gb" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 20
}

variable "network" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork name"
  type        = string
}

variable "metadata" {
  description = "Metadata for instances"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Network tags"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "enable_secure_boot" {
  type        = bool
  default     = false
  description = "Enable secure boot for shielded VM"
}

variable "enable_vtpm" {
  type        = bool
  default     = true
  description = "Enable vTPM for shielded VM"
}

variable "enable_integrity_monitoring" {
  type        = bool
  default     = true
  description = "Enable integrity monitoring"
}

variable "zone" {
  description = "The zone for the zonal managed instance group"
  type        = string
}

