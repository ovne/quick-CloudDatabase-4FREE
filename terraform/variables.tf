# Variables

variable "GCP_Project_Params" {
  description = "a map of commomly used project params"
  type        = map(string)
  default = {
    "project_id"                = "<project-id>"
    "project_region"            = "us-central1"
    "project_zone"              = "us-central1-a"
    "impersonation_service_acc" = "<impersonatio-service-account-email>"
  }
}