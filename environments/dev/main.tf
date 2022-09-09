module "vpc" {
  source = "../../modules/kubernetes/vpc"
}

module "gke" {
  source  = "../../modules/kubernetes"
  
  env_name = var.env_name
  
  # required variables
  project_id                 = var.project_id
  cluster_name               = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
    
  machine_type              = var.machine_type
  min_count                 = var.min_count
  max_count                 = var.max_count
  disk_size_gb    =   var.disk_size_gb

  pod_ipv4_cidr_range  = var.pod_ipv4_cidr_range
  initial_node_count        = var.initial_node_count
    
  ip_range_services_name = var.ip_range_services_name
  subnetwork_ipv4_cidr_range  = var.subnetwork_ipv4_cidr_range
    
  ip_range_pods_name  = var.ip_range_pods_name
    
  services_ipv4_cidr_range  = var.services_ipv4_cidr_range
    
  service_account = var.service_account
    
  
}


