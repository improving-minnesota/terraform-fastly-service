locals {
  headers = concat(
    local.global_headers,
    [
      {
        action      = "set"
        destination = "http.Strict-Transport-Security"
        name        = "Generated by force TLS and enable HSTS"
        source      = "\"max-age=31557600\""
        type        = "response"
      },
    ]
  )
}
