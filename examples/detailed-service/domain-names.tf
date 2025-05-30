locals {
  domain_names = [
    {
      name    = "${var.base_domain_prefix}.${var.base_domain_name}"
      comment = "Primary Example Domain Name"
    }
  ]
}
