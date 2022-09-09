project_id = "dera-gcp-infra-dev"

region = "europe-west4"
zones  = ["europe-west4-a"]
cluster_name  = "yq-dev"
env_name = "dev"
machine_type  = "e2-medium"
# default = "n1-standard-1"
min_count = 1
max_count  = 1
disk_size_gb = 50

network  = "dera-gke-network"
subnetwork  = "dera-gke-subnet"
subnetwork_ipv4_cidr_range = "10.20.0.0/14"
ip_range_pods_name = "ip-range-pods"
pod_ipv4_cidr_range  = "10.24.0.0/14"
ip_range_services_name  = "ip-range-services"
services_ipv4_cidr_range = "10.28.0.0/20"
service_account = "dera-dev-sa"
initial_node_count = 1
