variable "project_id" {
  description = "The project ID to host the network in"
}

variable "region" {
  type        = string
  description = "The region to create the cluster."
}

variable "network_name" {
  description = "The name of the VPC network being created"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
}

variable "subnetwork_ipv4_cidr_range" {
  description = "The subnetwork ip cidr block range."
}

variable "pods_ip_range_name" {
  description = "The secondary ip range to use for pods"
}

variable "pods_ip_cidr_range" {
  description = "The cidr ip range to use for pods"
}


variable "services_ip_range_name" {
  description = "The secondary ip range to use for services"
}

variable "services_ip_cidr_range" {
  description = "The cidr ip range to use for services"
}
