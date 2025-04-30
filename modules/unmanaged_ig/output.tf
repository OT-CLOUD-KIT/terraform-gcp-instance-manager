output "unmanaged_instance_group_ids" {
  description = "Unmanaged Instance Group resource self-links"
  value       = { for k, v in google_compute_instance_group.umig : k => v.self_link }
}
