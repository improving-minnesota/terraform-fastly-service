locals {
  acls = [
    {
      name = "office_proxy"
      # force_destroy = true
      manage_entries = true
      entries = [
        { ip = "192.168.1.1" },
        { ip = "192.168.1.2" },
      ]
    },
    {
      name = "main_office"
      # force_destroy = true
      manage_entries = true
      entries = [
        {
          ip     = "192.168.2.0"
          subnet = "24"
        },
        { ip = "192.168.3.1" },
      ]
    },
  ]
}
