terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-key.json")
  project = var.project_id
  region = var.region
  zone = var.zone
}

output "project_id" {
  description = "ID du projet GCP"
  value       = var.project_id
}