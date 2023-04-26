module "cache_gcs" {
  source                 = "./modules/cache"
  count                  = var.cache_bucket_create ? 1 : 0
  bucket_name            = local.bucket_name
  bucket_location        = var.cache_location != null ? var.cache_location : var.region
  bucket_labels          = local.runners_labels
  prefix                 = var.prefix
  runner_service_account = var.service_account_agent
}
