module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 5.2.0"
  
  project_id   = var.project_id
  network_name = "${var.network}-${var.env_name}-vpc"
  
  subnets = [
    {
      subnet_name              = "${var.subnetwork}-${var.env_name}-subnet"
      subnet_ip                = "${var.subnetwork_ipv4_cidr_range}"
      subnet_region            = var.region
      subnet_private_access    = "true"
      subnet_flow_logs         = "true"
      description              = var.subnet_description
    },
  ]
  
  secondary_ranges = {
    "${var.subnetwork}-${var.env_name}-subnet" = [
      {
        range_name    = var.pods_ip_range_name
        ip_cidr_range = var.pods_ip_cidr_range
      },
      {
        range_name    = var.services_ip_range_name
        ip_cidr_range = var.services_ip_cidr_range
      }
    ]
  }
}
