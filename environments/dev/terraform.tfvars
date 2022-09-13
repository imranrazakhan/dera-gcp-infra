project_id = "dera-gcp-infra-dev"

# Create a regional cluster with a multi-zone node pool
cluster_name  = "yq-dev"
env_name = "dev"
machine_type  = "n1-standard-1"
# default = "n1-standard-1"
min_count = 1
max_count  = 1
disk_size_gb = 40

region = "europe-west2"
zones  = ["europe-west2-b"]
node_locations = "europe-west2-b"


network_name = "dera-gke-network-dev"

network  = "dera-gke-network-dev"
subnetwork  = "dera-gke-subnet-dev"
# Maximum 12 nodes
subnetwork_ipv4_cidr_range = "10.10.0.0/28"
pods_ip_range_name = "ip-range-pods"

# /21 Smallest possible Pod IP range when the secondary range assignment method is managed by GKE
pods_ip_cidr_range  = "10.20.0.0/21"

services_ip_range_name  = "ip-range-services"
# Maximum 512 number of Services
services_ip_cidr_range = "10.30.0.0/23"
service_account = "dera-dev-sa"
initial_node_count = 1
