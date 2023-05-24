# Purpose: This file is used to configure the backend for terraform state file

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

# This provider is used to generate the access token
provider "google" {
  alias = "tokegen"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

# This data is used to get the access token
data "google_service_account_access_token" "SAToken" {
  provider               = google.tokegen
  target_service_account = var.GCP_Project_Params.impersonation_service_acc
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "600s"
}

# This provider is used to create resources
provider "google" {
  project         = var.GCP_Project_Params.project_id
  access_token    = data.google_service_account_access_token.SAToken.access_token
  request_timeout = "60s"
}