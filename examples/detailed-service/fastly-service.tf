module "fastly_service" {
  source               = "../.."
  fastly_api_key       = var.fastly_api_key
  fastly_force_destroy = true

  fastly_acls               = local.acls
  fastly_backends           = local.backends
  fastly_cache_setting      = local.cache_setting
  fastly_conditions         = local.conditions
  fastly_dictionaries       = local.dictionaries
  fastly_directors          = local.directors
  fastly_domain_names       = local.domain_names
  fastly_dynamic_snippets   = local.dynamic_snippets
  fastly_gzip_settings      = local.gzip_settings
  fastly_headers            = local.headers
  fastly_healthchecks       = local.healthchecks
  fastly_image_optimizers   = local.image_optimizers
  fastly_product_enablement = local.product_enablement
  fastly_rate_limiters      = local.rate_limiters
  fastly_request_settings   = local.request_settings
  fastly_response_objects   = local.response_objects
  fastly_snippets           = local.snippets
  fastly_vcls               = local.vcls
}
