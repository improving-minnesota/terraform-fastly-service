locals {
  domain_names = concat(
    local.global_domain_names,
    [
      {
        name = "www.${var.base_domain_prefix}.${var.base_domain_name}"
      },
    ]
  )
}
