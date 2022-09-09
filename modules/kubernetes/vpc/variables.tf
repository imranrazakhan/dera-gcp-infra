variable "project_id" {
  description = "The project ID to host the network in"
}

variable "network_name" {
  description = "The name of the VPC network being created"
}

variable "env_name" {
  description = "The environment for the GKE cluster"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
}

variable "pod_ipv4_cidr_range" {
  description = "The cidr ip range to use for pods"
}


variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
}

variable "services_ipv4_cidr_range" {
  description = "The cidr ip range to use for services"
}
