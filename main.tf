terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Use the variables from your variables.tf file
provider "google" {
  project = var.project_name
  region  = var.region
}

# 1. Enable Services 
resource "google_project_service" "gcp_services" {
  for_each = toset(["bigquery.googleapis.com", "storage.googleapis.com"])
  project  = var.project_name
  service  = each.key

  disable_on_destroy = false 
}

# 2. Create the Storage Bucket
resource "google_storage_bucket" "csv_bucket" {
  # This creates a name like: terraform-gcp-bigquery01-testing-terraform-gcp-bigquery01
  name          = "${var.project_name}-${var.environment}-${var.bucket_name}"
  location      = var.region
  force_destroy = true 
  
  depends_on = [google_project_service.gcp_services]
}

# 3. Create BigQuery Datasets
resource "google_bigquery_dataset" "test_customers_old" {
  dataset_id = "TestCustomersOld"
  location   = var.region
  
  depends_on = [google_project_service.gcp_services]
}

resource "google_bigquery_dataset" "test_customers_new" {
  dataset_id = "TestCustomersNew"
  location   = var.region
  
  depends_on = [google_project_service.gcp_services]
}