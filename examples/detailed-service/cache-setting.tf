locals {
  cache_setting = [
    {
      action          = "cache"
      cache_condition = "cache_condition"
      name            = "cache_setting"
      stale_ttl       = 3600
      ttl             = 3600
    }
  ]
}
