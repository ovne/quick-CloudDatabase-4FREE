terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
    }   
  }
}

provider "google" {
    alias = "tokegen"
    scopes = [ 
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/userinfo.email",
    ] 
 }

data "google_service_account_access_token" "SAToken" {
    provider = google.tokegen
    target_service_account = ""
    scopes = ["userinfo-email", "cloud-platform"]
    lifetime = "600s"
 }

provider "google" {
    project = ""
    access_token = data.google_service_account_access_token.SAToken.access_token
    request_timeout = "60s"
 }

variable "GCP_Project_Params" {
    description = "a map of commomly used project params"
    type = map(string)
    default = {
      "project_id" = "value"
      "project_region" = "us-central1"
      "project_zone" = "us-central1-a"
      "impersonation_service_acc" = "cloud-adm@projeto-estudos-356715.iam.gserviceaccount.com"
    } 
}

resource "" "name" {
  
}


module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.GCP_Project_Params.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ingrees-postgres"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = "allow-tcp-on-5432"
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