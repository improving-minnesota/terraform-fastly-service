output "fastly_service_name" {
  description = "The name of the Fastly Service that was updated."
  value       = fastly_service_vcl.this.name
}

output "fastly_service_id" {
  description = "The ID of the Fastly Service that was updated."
  value       = fastly_service_vcl.this.id
}
