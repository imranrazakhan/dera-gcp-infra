module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 5.2.0"
  
  project_id   = var.project_id
  network_name = "${var.network}-${var.env_name}-vpc"
  
  subnets = [
    {
      subnet_name              = "${var.subnetwork}-${var.env_name}-subnet"
      subnet_ip                = "${var.subnetwork_cidr}"
      subnet_region            = var.region
      subnet_private_access    = "true"
      subnet_flow_logs         = "true"
      description              = var.subnet_description
    },
  ]
  
  secondary_ranges = {
    "${var.subnetwork}-${var.env_name}-subnet" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = var.ip_range_pods_cidr
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = var.ip_range_services_cidr
      }
    ]
  }
}
