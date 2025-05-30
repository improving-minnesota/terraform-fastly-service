locals {
  rate_limiters = concat(
    local.global_rate_limiters,
  )
}
