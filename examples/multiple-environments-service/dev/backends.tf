locals {
  backends = concat(
    local.global_backends,
    [
      {
        name              = "backend-3"
        address           = "backend-3.${var.base_domain_prefix}.${var.base_domain_name}"
        request_condition = "REQUEST Client IP 127.0.0.1"
      },
    ]
  )
}
