module "vpc" {
  source = "../../modules/kubernetes"
}

module "gke" {
  source  = "../../modules/kubernetes"
}


