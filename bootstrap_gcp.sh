#!/bin/bash

authorise_gcp() {

  # The command will automatically open a browser, and you will be once again prompted to log in with your Google credentials.
  gcloud auth application-default login
  
  gcloud config set project $GCP_PROJECT
  gcloud config set compute/zone $GCP_ZONE
  
  # The required API's that need to be enabled are the compute and container ones.
  gcloud services enable compute.googleapis.com
  gcloud services enable container.googleapis.com
  gcloud services enable servicenetworking.googleapis.com
  gcloud services enable cloudresourcemanager.googleapis.com
  
  # Created a Google service account by running the following command:
  gcloud iam service-accounts create <service-account name>
  
  # Grant the required roles below for the service account, so that Terraform can create GKE clusters and any other resources needed
  gcloud projects add-iam-policy-binding <project_name> --member serviceAccount:<service_account_name>@<project_name>.iam.gserviceaccount.com --role roles/iam.serviceAccountUser
  gcloud projects add-iam-policy-binding <project_name> --member serviceAccount:<service_account_name>@<project_name>.iam.gserviceaccount.com --role roles/resourcemanager.projectIamAdmin
  gcloud projects add-iam-policy-binding <project_name> --member serviceAccount:<service_account_name>@<project_name>.iam.gserviceaccount.com --role roles/container.admin
  gcloud projects add-iam-policy-binding <project_name> --member serviceAccount:<service_account_name>@<project_name>.iam.gserviceaccount.com --role roles/compute.admin

  # Creat and downloaded a .json key for the service account with the command below. This key will be used for authentication for terraform and the CICD platform
  gcloud iam service-accounts keys create <service-key.json> --iam-account=<service_account_name>@<project_name>.iam.gserviceaccount.com

  # Provisioning a cluster using the gcloud
  gcloud container clusters create learnk8s-cluster --zone europe-west1-b
}


