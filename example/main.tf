module "mig" {
  source                      = "./modules/managed_ig"
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
  source  = "./modules/unmanaged_ig"
  umigs   = var.umigs
  network = var.network
}
