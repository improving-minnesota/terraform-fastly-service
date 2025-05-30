locals {
  global_dynamic_snippets = [
    {
      name     = "ngwaf_config_deliver"
      type     = "deliver"
      priority = 150
      manage   = false
    },
    {
      name     = "ngwaf_config_init"
      type     = "init"
      priority = 0
      manage   = false
    },
    {
      name     = "ngwaf_config_miss"
      type     = "miss"
      priority = 150
      manage   = false
    },
    {
      name     = "ngwaf_config_pass"
      type     = "pass"
      priority = 150
      manage   = false
    },
  ]
}
