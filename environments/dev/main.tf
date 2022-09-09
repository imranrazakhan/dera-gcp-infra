module "vpc" {
  source = "../../modules/kubernetes"
}

module "gke" {
  source  = "../../modules/kubernetes"
  project_id  = var.project_id
}


