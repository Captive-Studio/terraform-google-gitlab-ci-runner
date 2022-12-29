output "service_account_agent" {
  value       = google_service_account.agent
  description = "Agent Service account"
}

output "service_account_runner" {
  value       = google_service_account.runner
  description = "Runner Service account"
}

