variable "project_id" {
  type        = string
  description = "The project ID to create the cluster."
}

variable "region" {
  type        = string
  description = "The region to create the cluster."
}

variable "zones" {
  type        = list(string)
  description = "The zones to create the cluster."
}

variable "node_locations" {
  type        = string
  description = "The locaions to create the node pool."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}

variable "network_name" {
  description = "The name of the VPC network being created"
}

variable "env_name" {
  description = "The environment for the GKE cluster"
}

variable "machine_type" {
  type        = string
  description = "Type of the node compute engines."
}

#variable "cpus" {
#  description = "Number of cpus"
#  default     = "2"
#}

variable "min_count" {
  type        = number
  description = "Minimum number of nodes in the NodePool. Must be >=0 and <= max_node_count."
}

variable "max_count" {
  type        = number
  description = "Maximum number of nodes in the NodePool. Must be >= min_node_count."
}

variable "disk_size_gb" {
  type        = number
  description = "Size of the node's disk."
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}

variable "network" {
  description = "The VPC network created to host the cluster in"
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


variable "iam_roles_list" {
  description = "List of IAM roles to be assigned to GKE service account"
  type        = list(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ]
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
}

variable "ssh_user" {
  description = "The user that Ansible will use"
  default     = "root"
}

variable "key_pairs" {
  type = map
  default = {
    root_public_key  = "keys/root_id_ed25519.pub",
    root_private_key = "keys/root_id_ed25519"
  }
}

variable "bastion_members" {
  type        = list(string)
  description = "List of users, groups, SAs who need access to the bastion host"
  default     = []
}

