# Provisioning GKE Cluster using Terraform

If you only use the basic default public GKE cluster (with nodes exposed to the internet), provisioning is a simple, as you can get by with google_container_resource.

In Google Cloud, the default public GKE cluster can be setup with defaults options easily easily with google_container_resource and google_container_node_pool.

The complexity shoots up dramatically if you veer away from default options, such as using private cluster. For this scenarios, it will be easier to use a module that encapsulates this complexity, such as Hashicorp-Google’s Kubernetes Engine.

Step 1 :- 
Create Google Cloud Account and login
Create a project in your Google Cloud Account Cloud Console 

Step 2 :- In order for Terraform to run operations on your behalf, you must install and configure the gcloud SDK tool.

