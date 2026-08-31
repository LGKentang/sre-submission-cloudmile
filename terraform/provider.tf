terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
  }
  
  backend "gcs" {
    bucket = "cloudmile-sre-asg-darren-maverick"
    prefix = "nexus-gke-sre/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
