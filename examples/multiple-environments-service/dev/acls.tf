locals {
  acls = concat(
    local.global_acls,
  )
}
