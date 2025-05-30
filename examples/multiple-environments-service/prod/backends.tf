locals {
  backends = concat(
    local.global_backends,
  )
}
