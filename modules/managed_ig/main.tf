resource "google_compute_instance_template" "instance_template" {
  name_prefix = "${replace(var.name, "_", "-")}-template-"
  machine_type = var.machine_type
  region       = var.region

  disk {
    auto_delete  = true
    boot         = true
    source_image = var.source_image
    disk_type    = var.boot_disk_type
    disk_size_gb = var.boot_disk_size_gb
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {}
  }

  metadata = var.metadata
  tags     = var.tags

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  shielded_instance_config {
    enable_secure_boot          = var.enable_secure_boot
    enable_vtpm                 = var.enable_vtpm
    enable_integrity_monitoring = var.enable_integrity_monitoring
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  for_each           = { for inst in var.migs : inst.name => inst }
  name               = each.value.name
  region             = var.region
  base_instance_name = each.value.name
  target_size        = each.value.target_size

  version {
    instance_template = google_compute_instance_template.instance_template.id
  }

  dynamic "named_port" {
    for_each = each.value.named_ports
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "auto_healing_policies" {
    for_each = each.value.enable_auto_healing ? [1] : []
    content {
      health_check      = each.value.health_check
      initial_delay_sec = each.value.auto_healing_delay
    }
  }
}

resource "google_compute_region_autoscaler" "mig_autoscaler" {
  for_each = {
    for inst in var.migs : inst.name => inst
    if inst.enable_autoscaling
  }

  name   = "${replace(each.value.name, "_", "-")}-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.mig[each.key].self_link

  depends_on = [google_compute_region_instance_group_manager.mig]

  autoscaling_policy {
    min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas

    cpu_utilization {
      target = each.value.target_cpu_utilization
    }
  }
}

