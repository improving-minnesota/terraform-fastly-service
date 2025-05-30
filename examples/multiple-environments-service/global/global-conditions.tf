locals {
  global_conditions = [
    {
      name      = "CACHE 503 Synthetic Response"
      type      = "CACHE"
      priority  = "0"
      statement = "beresp.status == 503"
    },
    {
      name      = "REQUEST URL /foo/bar"
      type      = "REQUEST"
      statement = "req.url == \"/foo/bar\""
    },
    {
      name      = "cache_condition"
      priority  = 10
      statement = "req.url ~ \"^/cacheable-path\""
      type      = "CACHE"
    }
  ]
}
