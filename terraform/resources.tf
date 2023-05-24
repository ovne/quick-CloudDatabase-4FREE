
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.GCP_Project_Params.project_id
  network_name = "default"

  rules = [{
    name                    = "allow-ingrees-postgres"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["allow-tcp-on-5432"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["5432"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}


resource "google_compute_instance" "postgresql-server" {

  machine_type = "e2-micro" // REQUIRED to free-tier
  name         = "postgresql-server"
  zone         = "us-central1-a"
  boot_disk {
    auto_delete = true
    device_name = "postgresql-server"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230509"
      size  = 10            //up to 30GB to free-tier
      type  = "pd-standard" // REQUIRED to free-tier
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    ec-src = "vm_add-tf"
  }

  tags = ["allow-tcp-on-5432"] //network tags attached (same as firewall rules)
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/projeto-estudos-356715/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = var.GCP_Project_Params.impersonation_service_acc
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  metadata_startup_script = file("../script.sh")

}