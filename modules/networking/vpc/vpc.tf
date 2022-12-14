module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 5.2.0"
  
  project_id   = var.project_id
  network_name = var.network_name
  
  subnets = [
    {
      subnet_name              = var.subnetwork
      subnet_ip                = var.subnetwork_ipv4_cidr_range
      subnet_region            = var.region
      subnet_private_access    = "true"
      subnet_flow_logs         = "true"
    },
  ]
  
  secondary_ranges = {
    "${var.subnetwork}" = [
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
  
