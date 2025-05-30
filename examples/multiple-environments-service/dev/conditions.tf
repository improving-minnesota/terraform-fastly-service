locals {
  conditions = concat(
    local.global_conditions,
    [
      {
        name      = "REQUEST Client IP 127.0.0.1"
        type      = "REQUEST"
        statement = "client.ip == \"127.0.0.1\""
      },
    ]
  )
}
