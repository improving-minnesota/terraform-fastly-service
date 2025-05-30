locals {
  global_healthchecks = [
    {
      headers = [
        "Accept: application/json",
        "User-Agent: fastly-healthchecks",
      ]
      host = "backend-2.${var.base_domain_prefix}.${var.base_domain_name}"
      name = "backend-2"
      path = "/healthcheck"
    },
  ]
}
