locals {
  default_labels = {
    "managed-by" = "terraform"
  }
  bucket_labels = merge({
    "role" = "gitlab-runner"
  }, local.default_labels, var.bucket_labels)
  bucket_name = var.bucket_name != null ? var.bucket_name : "${var.prefix}-cache-${random_id.suffix.hex}"
}
