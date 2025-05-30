locals {
  image_optimizers = concat(
    local.global_image_optimizers,
  )
}
