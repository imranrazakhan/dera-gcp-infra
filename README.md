# Provisioning GKE Cluster using Terraform

If you only use the basic default public GKE cluster (with nodes exposed to the internet), provisioning is a simple, as you can get by with google_container_resource.

In Google Cloud, the default public GKE cluster can be setup with defaults options easily with google_container_resource and google_container_node_pool.

The complexity come if we deviate from default options, such as using private cluster. For this scenarios, it will be easier to use a module that encapsulates this complexity, such as Hashicorp Google's Kubernetes Engine.

## Requirements

- A Google Project – GCP organizes resources into projects. Create one now in the GCP console and make note of the project ID.
- In order for Terraform to run operations on your behalf, Create a service account key to enable Terraform to access your GCP account.

