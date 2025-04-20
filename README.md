## Terraform GCP Managed & Unmanaged Instance Group

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform configuration manages GCP instance groups with modular support for both Managed and Unmanaged types. It defines an Instance Template used by Managed Instance Groups (MIGs) with features like secure boot, auto-healing, and autoscaling policies. The managed_ig module provisions MIGs across regions using dynamic blocks for flexibility. The unmanaged_ig module provisions unmanaged instance groups (UMIGs) based on existing VM instances, with support for named ports and network configuration.

## Architecture

<img width="6000" length="8000" alt="Terraform" src="https://github.com/user-attachments/assets/84ad9af5-c004-4ef0-aba1-6dfc8d95c8d6">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 5.0.0   |

## Usage

```hcl
module "mig" {
  source                      = "./managed_ig"
  region                      = var.region
  zone                        = var.zone
  name                        = var.name
  migs                        = var.migs
  machine_type                = var.machine_type
  source_image                = var.source_image
  boot_disk_type              = var.boot_disk_type
  boot_disk_size_gb           = var.boot_disk_size_gb
  network                     = var.network
  subnetwork                  = var.subnetwork
  metadata                    = var.metadata
  tags                        = var.tags
  service_account_email       = var.service_account_email
  service_account_scopes      = var.service_account_scopes
  enable_secure_boot          = var.enable_secure_boot
  enable_vtpm                 = var.enable_vtpm
  enable_integrity_monitoring = var.enable_integrity_monitoring
}

module "umig" {
  source  = "./unmanaged_ig"
  umigs   = var.umigs
  network = var.network
}

```

## Inputs

| Name | Description | Type | Default | Required | 
|------|-------------|:----:|---------|:--------:|
|**project_id**| The ID of the project for which the IAM resource is to be configured | string | { } | yes| 
|**region**| The Google Cloud region | string | us-central1 | yes | 
|**zone**| The zone for the zonal managed instance group | string | { } |yes| 
|**name**| Base name used for naming resources like templates or instance groups | string | { } | yes| 
|**migs** | List of managed instance group configurations | list(object) | [ ] | yes|
|**machine_type**| Machine Type | string | { } | yes | 
|**source_image**| Source image for the boot disk | string | { } | yes| 
|**boot_disk_type**| Boot Disk Type | string | "pd-balanced" | yes| 
|**boot_disk_size_gb** | List of service projects | number | "20" | yes|
|**network**| VPC network name | string | { } | yes | 
|**subnetwork**| Subnetwork name | string | { } | yes|
|**metadata**| Metadata for instances | map(string) | { } | yes| 
|**tags** | Network tags | list(string) | [ ] | yes|
|**service_account_email**| Service Account Email | string | { } | yes | 
|**service_account_scopes**| Service Account Scopes | list(string) | "https://www.googleapis.com/auth/cloud-platform" | yes|
|**enable_secure_boot**| Enable secure boot for shielded VM | bool | false | yes | 
|**enable_vtpm**| Enable vTPM for shielded VM | bool | true | yes|
|**enable_integrity_monitoring**| Enable Integrity Monitoring | bool | true | yes| 
|**umigs** | List of unmanaged instance group configurations | list(object) | [ ] | yes|


## Output
| Name | Description |
|------|-------------|
|**managed_instance_groups**| Self-links of Managed Instance Groups | 
|**instance_template_id**| The ID of the Instance Template |
|**instance_template_self_link**| The self-link of the Instance Template |
|**unmanaged_instance_group_ids**| Unmanaged Instance Group resource self-links |
                                                                                                                  
