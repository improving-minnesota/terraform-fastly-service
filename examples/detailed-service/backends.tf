locals {
  backends = [
    {
      name    = "backend"
      address = "backend.${var.base_domain_prefix}.${var.base_domain_name}"
      weight  = 50
    },
    {
      name        = "backend-2"
      address     = "backend-2.${var.base_domain_prefix}.${var.base_domain_name}"
      healthcheck = "backend-2"
      weight      = 50
    },
    {
      name              = "backend-3"
      address           = "backend-3.${var.base_domain_prefix}.${var.base_domain_name}"
      request_condition = "REQUEST URL /foo/bar"
    },
  ]
}
