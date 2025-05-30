locals {
  healthchecks = concat(
    local.global_healthchecks,
  )
}
