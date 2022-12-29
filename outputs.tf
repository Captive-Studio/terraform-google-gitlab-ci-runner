output "service_account_agent" {
  value       = google_service_account.agent
  description = "Agent Service account"
}

output "service_account_runner" {
  value       = service_account_runner.runner
  description = "Runner Service account"
}

