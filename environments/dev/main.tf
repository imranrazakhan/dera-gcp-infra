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

  node_pools = [
    {
      name                      = "${var.project_name}-gke-node-pool"
      machine_type              = var.machine_type
      node_locations            = "europe-west1-b,europe-west1-c,europe-west1-d"
      min_count                 = var.min_count
      max_count                 = var.max_count
      local_ssd_count           = var.disk_size_gb
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      # service_account           = var.service_account
      #   service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = var.initial_node_count
    },
  ]

}


