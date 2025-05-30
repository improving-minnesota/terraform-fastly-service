locals {
  gzip_settings = concat(
    local.global_gzip_settings,
  )
}
