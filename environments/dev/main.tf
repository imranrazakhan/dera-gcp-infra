module "vpc" {
  source = "../../modules/networking/vpc"
  project_id    = var.project_id
  network_name  = var.network
  region        = var.region
  
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
  location     = "europe-west3"
  cluster_name = var.cluster_name
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
  
  network                    = var.network_name
  subnetwork                 = var.subnetwork
  
  network_name               = var.network_name
    
  machine_type              = var.machine_type
  min_count                 = var.min_count
  max_count                 = var.max_count
  disk_size_gb    =   var.disk_size_gb
  node_locations            = var.node_locations

  initial_node_count        = var.initial_node_count
    
  #service_account = var.service_account
  
  subnetwork_ipv4_cidr_range = var.subnetwork_ipv4_cidr_range
  
  pods_ip_range_name      = var.pods_ip_range_name
  pods_ip_cidr_range      = var.pods_ip_cidr_range
  services_ip_range_name  = var.services_ip_range_name
  services_ip_cidr_range  = var.services_ip_cidr_range
}

module "argocd" {
  source = "../../modules/argocd"

  argocd_project_name                      = "my-project"
  argocd_repository_name                   = "gitlab-argo"
  argocd_repository_url                    = "https://gitlab.com/foo/argo.git"
  argocd_repository_username               = "foo"
  argocd_repository_password               = "bar123"
  argocd_application_name                  = "root-app"
  argocd_application_repo_branch           = "dev"
  argocd_application_repo_path             = "argocd/manifests"
}

