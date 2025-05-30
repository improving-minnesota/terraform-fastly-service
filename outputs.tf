output "fastly_service_name" {
  value = fastly_service_vcl.this.name
}

output "fastly_service_id" {
  value = fastly_service_vcl.this.id
}
