module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 23.0.0"
  
  # required variables
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = var.ip_range_pods_name              # join("-",[var.subnetwork,"pods"])
  ip_range_services          = var.ip_range_services_name          # join("-",[var.subnetwork,"services"])
    
  # addons
  http_load_balancing        = false
  network_policy             = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  
  # optional variables
  remove_default_node_pool   = true
   # kubernetes_version          = "latest"
   # regional                 = true
   # create_service_account   = false

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
      service_account           = var.service_account
      #   service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = var.initial_node_count
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []
  }
}
    
#resource "google_compute_firewall" "ssh-rule" {
#  depends_on   = [module.gke]
#  name = "ssh"
#  network  = "${var.network}-${var.env_name}"
#  project  = "${var.project_id}"
#  allow {
#    protocol = "tcp"
#    ports = ["22"]
#  }
#  source_ranges = ["0.0.0.0/0"]
#   depends_on = [module.gke]
#}
    
#resource "google_compute_project_metadata" "ansible_ssh_key" {
#  project = var.project_id
#  metadata = {
#    ssh-keys = "${var.ssh_user}:${file(var.key_pairs["root_public_key"])}"
#  }
#}
