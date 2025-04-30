region     = "us-central1"
network    = "projects/nw-opstree-dev-landing-zone/global/networks/default"
subnetwork = "default"
project_id = "nw-opstree-dev-landing-zone"
name       = "mig-instance"
zone       = "us-central1-c"
migs = [
  {
    name                   = "managed-instance-group"
    target_size            = 2
    named_ports            = [{ name = "http", port = 80 }]
    enable_auto_healing    = true
    auto_healing_delay     = 300
    health_check           = ""
    enable_autoscaling     = true
    min_replicas           = 1
    max_replicas           = 2
    target_cpu_utilization = 0.6
  }
]

umigs = [
  {
    name = "unmanaged-instance-group"
    zone = "us-central1-c"
    instances = [
      "https://www.googleapis.com/compute/v1/projects/nw-opstree-dev-landing-zone/zones/us-central1-c/instances/instance-20250417-094241",
      "https://www.googleapis.com/compute/v1/projects/nw-opstree-dev-landing-zone/zones/us-central1-c/instances/instance-20250417-094301"
    ]
    named_ports = [{ name = "db", port = 5432 }]
  }
]

machine_type                = "e2-medium"
source_image                = "projects/debian-cloud/global/images/family/debian-11"
boot_disk_type              = "pd-balanced"
boot_disk_size_gb           = 20
metadata                    = {}
tags                        = ["testing"]
service_account_email       = "service-account"
service_account_scopes      = ["https://www.googleapis.com/auth/cloud-platform"]
enable_secure_boot          = false
enable_vtpm                 = true
enable_integrity_monitoring = true
