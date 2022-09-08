module "vpc" {
  source = "../../modules/kubernetes/vpc"
}

module "gke" {
  source  = "../../modules/kubernetes/gke"
}


