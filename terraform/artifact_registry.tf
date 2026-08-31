# Artifact Registry Docker repository for custom Nexus image
resource "google_artifact_registry_repository" "nexus_images" {
  project       = var.project_id
  location      = var.region
  repository_id = var.artifact_registry_repo
  format        = "DOCKER"
  description   = "Custom Nexus3 + GCS blobstore plugin image"

  labels = {
    app         = "nexus"
    environment = var.environment
  }
}

# GKE node service account needs read access to pull the image. The default
# node service account gets this implicitly via the broad cloud-platform
# OAuth scope set in gke.tf, but an explicit IAM grant here is the correct,
# least-privilege way to do it and works even if that scope is narrowed
# later.
resource "google_artifact_registry_repository_iam_member" "gke_pull" {
  project    = google_artifact_registry_repository.nexus_images.project
  location   = google_artifact_registry_repository.nexus_images.location
  repository = google_artifact_registry_repository.nexus_images.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com"
}

data "google_project" "current" {
  project_id = var.project_id
}
