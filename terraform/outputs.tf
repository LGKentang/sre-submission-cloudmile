output "gcs_bucket_name" {
  description = "Name of the GCS bucket for Nexus blob store"
  value       = google_storage_bucket.nexus_blobstore.name
}

output "gke_cluster_name" {
  value = google_container_cluster.nexus.name
}

output "gke_cluster_endpoint" {
  value     = google_container_cluster.nexus.endpoint
  sensitive = true
}

output "nexus_gcs_service_account_email" {
  description = "GCP service account Nexus impersonate by Workload Identity"
  value       = google_service_account.nexus_gcs.email
}

output "get_credentials_command" {
  description = "Command to fetch kubeconfig"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.nexus.name} --zone ${var.zone} --project ${var.project_id}"
}
