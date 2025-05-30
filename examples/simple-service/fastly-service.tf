module "fastly_service" {
  source               = "../.."
  fastly_api_key       = var.fastly_api_key
  fastly_force_destroy = true

  fastly_backends     = local.backends
  fastly_domain_names = local.domain_names
}
