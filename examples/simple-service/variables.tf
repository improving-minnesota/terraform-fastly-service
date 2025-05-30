variable "fastly_api_key" {
  description = "The Fastly API key"
  sensitive   = true
  type        = string
}

variable "base_domain_prefix" {
  description = "Base domain prefix"
  type        = string
}

variable "base_domain_name" {
  description = "Base domain prefix"
  type        = string
  default     = "user-mydomain.com"
}
