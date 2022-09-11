# Provisioning GKE Cluster using Terraform

If you only use the basic default public GKE cluster (with nodes exposed to the internet), provisioning is a simple, as you can get by with google_container_resource.

In Google Cloud, the default public GKE cluster can be setup with defaults options easily with google_container_resource and google_container_node_pool.

The complexity come if we deviate from default options, such as using private cluster. For this scenarios, it will be easier to use a module that encapsulates this complexity, such as Hashicorp Google's Kubernetes Engine.

## Requirements

- A Google Project – GCP organizes resources into projects. Create one now in the GCP console and make note of the project ID.
- Google Cloud offers an advanced permissions management system with Cloud Identity and Access Management (Cloud IAM). Terraform needs to be authorized to communicate with the Google Cloud API to create and manage resources in our GCP project. We achieve this by enabling the corresponding APIs and creating a service account with appropriate roles.
  - Run bootsrap_gcp.sh and it will do following tasks
    - Enable the Google Cloud APIs
    - Create a service account
    - Grant the necessary roles for our service account to create a GKE cluster and the associated resources.
    - Create and download a key file that Terraform will use to authenticate as the service account against the Google Cloud Platform API.

