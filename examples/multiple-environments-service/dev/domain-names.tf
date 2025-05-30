locals {
  domain_names = concat(
    local.global_domain_names,
  )
}
