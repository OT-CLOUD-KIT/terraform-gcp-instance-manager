output "managed_instance_group_ids" {
  description = "Managed Instance Group resource self-links"
  value       = { for k, v in google_compute_region_instance_group_manager.mig : k => v.self_link }
}

output "instance_template_id" {
  description = "The ID of the Instance Template"
  value       = google_compute_instance_template.instance_template.id
}

output "instance_template_self_link" {
  description = "The self-link of the Instance Template"
  value       = google_compute_instance_template.instance_template.self_link
}

