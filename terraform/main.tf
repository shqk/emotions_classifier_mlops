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

resource "google_cloud_run_service" "emotions_api" {
  location = var.region
  name     = "emotions-api"

  template {
    spec {
      containers {
        image = "eu.gcr.io/movie-predict-467214-k5/emotions-api:v1"

        ports {
          container_port = 80
        }

        resources {
          limits = {
            cpu = "1000m"
            memory = "2Gi"
          }
        }
      }
    }
  }
  traffic {
    percent = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  member  = "allUsers"
  role    = "roles/run.invoker"
  service = google_cloud_run_service.emotions_api.name
  location = google_cloud_run_service.emotions_api.location
}

output "api_url" {
  description = "URL publique de l'API"
  value = google_cloud_run_service.emotions_api.status[0].url
}