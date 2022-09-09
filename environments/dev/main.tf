module "vpc" {
  source = "../../modules/kubernetes/vpc"
  project_id                 = var.project_id
  network_name = "${var.network}-${var.env_name}-vpc"
  env_name    = var.env_name
  region = var.region
  
  subnetwork  = var.subnetwork
  subnetwork_ipv4_cidr_range = var.subnetwork_ipv4_cidr_range
  
  pods_ip_range_name      = var.pods_ip_range_name
  pods_ip_cidr_range      = var.pods_ip_cidr_range
  services_ip_range_name  = var.services_ip_range_name
  services_ip_cidr_range  = var.services_ip_cidr_range
  
}
  
module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location

}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.env_name}"
}

module "gke" {
  source  = "../../modules/kubernetes"
  
  env_name = var.env_name
  
  # required variables
  project_id                 = var.project_id
  cluster_name               = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  
  network                    = "${var.network_name}-${var.env_name}-vpc"
  subnetwork                 = "${var.subnetwork}-${var.env_name}-subnet"
  
  network_name = "${var.network_name}-${var.env_name}-vpc"
    
  machine_type              = var.machine_type
  min_count                 = var.min_count
  max_count                 = var.max_count
  disk_size_gb    =   var.disk_size_gb

  initial_node_count        = var.initial_node_count
    
  service_account = var.service_account
  
  subnetwork_ipv4_cidr_range = var.subnetwork_ipv4_cidr_range
  
  pods_ip_range_name      = var.pods_ip_range_name
  pods_ip_cidr_range      = var.pods_ip_cidr_range
  services_ip_range_name  = var.services_ip_range_name
  services_ip_cidr_range  = var.services_ip_cidr_range
}


