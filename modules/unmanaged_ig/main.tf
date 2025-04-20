resource "google_compute_instance_group" "umig" {
  for_each = { for ig in var.umigs : ig.name => ig }

  #name      = each.value.name
  name      = replace(each.value.name, "_", "-")
  zone      = each.value.zone
  instances = each.value.instances

  dynamic "named_port" {
    for_each = each.value.named_ports
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }

  network = var.network
  description = each.value.description
}
