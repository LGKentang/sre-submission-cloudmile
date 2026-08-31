resource "google_container_cluster" "nexus" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.zone # zonal cluster FOR cheaper price

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  deletion_protection = false
}

resource "google_container_node_pool" "nexus_pool" {
  name     = "${var.cluster_name}-pool"
  project  = var.project_id
  location = var.zone
  cluster  = google_container_cluster.nexus.name

  # Minimal footprint to keep cost down, per the task requirements.
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    preemptible  = var.preemptible
    disk_size_gb = 30
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      app = "nexus"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
