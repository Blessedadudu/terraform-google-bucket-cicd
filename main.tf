terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}


provider "google" {
  project = "singular-agent-452813-n6"
  region  = "europe-west1"
}

resource "google_storage_bucket" "vendor_bucket" {
  name     = "vendor-bucket-123t"
  location = "europe-west1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true  # Enforce uniform access control

  retention_policy {
    retention_period = 1209600  # 7 days (in seconds)
  }
}

# Grant read-only access to a Google Group
resource "google_storage_bucket_iam_member" "viewer_access_group" {
  bucket = google_storage_bucket.vendor_bucket.name
  role   = "roles/storage.objectViewer"
  member = "group:google-buckets-ven@googlegroups.com"
}
