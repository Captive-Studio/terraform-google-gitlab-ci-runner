resource "random_id" "suffix" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    bucket_name = var.bucket_name
  }
  byte_length = 4
}


#----------------------------
# create GCS bucket for cache
#-----------------------------

resource "google_storage_bucket" "cache" {
  name          = local.bucket_name
  location      = var.bucket_location
  force_destroy = true
  storage_class = var.bucket_storage_class

  versioning {
    enabled = var.bucket_versioning
  }

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = var.bucket_expiration_days
    }
    action {
      type = "Delete"
    }
  }
  labels = local.bucket_labels
}

#----------------------------------------------------------------
# Grant runner service account access to the above created bucket
#----------------------------------------------------------------

resource "google_storage_bucket_iam_member" "cache-member" {
  for_each = toset(concat(var.runner_service_account_email, [var.runner_service_account.email]))
  bucket   = google_storage_bucket.cache.name
  role     = "roles/storage.admin"
  member   = "serviceAccount:${each.value}"
}
