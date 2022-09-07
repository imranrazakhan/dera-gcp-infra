module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.name
  region                     = var.region
  zones                      = var.zones
  network                    = module.gcp-network.network_name
  subnetwork                 = module.gcp-network.subnets_names[0]
  ip_range_pods              = var.ip_range_pods_name              # join("-",[var.subnetwork,"pods"])
  ip_range_services          = var.ip_range_services_name          # join("-",[var.subnetwork,"services"])
  http_load_balancing        = false
  network_policy             = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  remove_default_node_pool   = "true"
  # kubernetes_version          = "latest"

  node_pools = [
    {
      name                      = "pool-1"
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
#}
    
#resource "google_compute_project_metadata" "ansible_ssh_key" {
#  project = var.project_id
#  metadata = {
#    ssh-keys = "${var.ssh_user}:${file(var.key_pairs["root_public_key"])}"
#  }
#}
