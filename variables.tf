variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
  default     = "01058B-DBDC3B-66D20E" 
}

variable "project_name" {
  default = "terraform-gcp-bigquery01"
}

variable "region" {
  default = "europe-west2" 
}

variable "environment" {
  default = "testing"
}

variable "bucket_name" {
  default = "data-bucket-01"
}