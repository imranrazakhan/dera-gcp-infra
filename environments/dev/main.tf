module "vpc" {
  source = "../../modules/kubernetes"
}

module "gke" {
  source  = "../../modules/kubernetes"
  # required variables
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = var.ip_range_pods_name              # join("-",[var.subnetwork,"pods"])
  ip_range_services          = var.ip_range_services_name          # join("-",[var.subnetwork,"services"])
    
  create_service_account = false
}


