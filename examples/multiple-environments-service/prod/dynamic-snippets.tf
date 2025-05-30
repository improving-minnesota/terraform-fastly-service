locals {
  dynamic_snippets = concat(
    local.global_dynamic_snippets,
  )
}
