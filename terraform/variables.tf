# Variables

variable "GCP_Project_Params" {
  description = "a map of commomly used project params"
  type        = map(string)
  default = {
    "project_id"                = "projeto-estudos-356715"
    "project_region"            = "us-central1"
    "project_zone"              = "us-central1-a"
    "impersonation_service_acc" = "cloud-adm@projeto-estudos-356715.iam.gserviceaccount.com"
  }
}