locals {
  global_backends = [
    {
      name    = "backend"
      address = "dev.backend.${var.base_domain_prefix}.${var.base_domain_name}"
      weight  = 50
    },
    {
      name        = "backend-2"
      address     = "dev.backend-2.${var.base_domain_prefix}.${var.base_domain_name}"
      healthcheck = "backend-2"
      weight      = 50
    },
  ]
}
