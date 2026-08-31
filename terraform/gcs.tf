resource "google_storage_bucket" "nexus_blobstore" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  project                     = var.project_id
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }

  labels = {
    app         = "nexus"
    environment = var.environment
  }
}

resource "google_service_account" "nexus_gcs" {
  project      = var.project_id
  account_id   = "nexus-gcs"
  display_name = "Nexus GCS blobstore access"
}

resource "google_storage_bucket_iam_member" "nexus_gcs_object_admin" {
  bucket = google_storage_bucket.nexus_blobstore.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.nexus_gcs.email}"
}

# Kubernetes ServiceAccount "nexus/nexus-sa" to act as this GCP service account via Workload Identity.
resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.nexus_gcs.name
  role                = "roles/iam.workloadIdentityUser"
  member              = "serviceAccount:${var.project_id}.svc.id.goog[nexus/nexus-sa]"
}
