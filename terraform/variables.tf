variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for the (zonal) GKE cluster"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "nexus-cluster"
}

variable "node_count" {
  description = "Number of nodes in the pool"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "GCE machine type for cluster nodes"
  type        = string
  default     = "n1-standard-1"
}

variable "preemptible" {
  description = "Use preemptible (short-lived, cheap) VMs or not"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "Name for the GCS bucket for Nexus blob store"
  type        = string
}

variable "bucket_location" {
  description = "GCS bucket Location[region or multi-region]"
  type        = string
  default     = "US"
}

variable "environment" {
  description = "Environment label, e.g. test or prod"
  type        = string
  default     = "test"
}
