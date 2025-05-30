locals {
  rate_limiters = [
    # Disabling, as this is requires paid features
    # {
    #   action               = "response"
    #   client_key           = "req.http.Fastly-Client-IP,req.http.User-Agent"
    #   http_methods         = "GET,PUT,TRACE,POST,HEAD,DELETE,PATCH,OPTIONS"
    #   name_suffix          = "Example"
    #   penalty_box_duration = 2
    #   response = {
    #     content      = "Rate Exceeded"
    #     content_type = "application/text"
    #     status       = 429
    #   }
    #   rps_limit   = 10
    #   window_size = 60
    # },
  ]
}
