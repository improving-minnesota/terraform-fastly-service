resource "fastly_service_vcl" "this" {
  activate           = var.fastly_activate
  comment            = var.fastly_service_comment
  default_host       = var.fastly_default_host
  default_ttl        = var.fastly_default_ttl
  force_destroy      = var.fastly_force_destroy
  http3              = var.fastly_http3
  name               = var.fastly_domain_names[0].name
  stage              = var.fastly_stage
  stale_if_error     = var.fastly_stale_if_error
  stale_if_error_ttl = var.fastly_stale_if_error_ttl

  dynamic "acl" {
    for_each = var.fastly_acls
    content {
      force_destroy = acl.value.force_destroy
      name          = acl.value.name
    }
  }

  dynamic "backend" {
    for_each = var.fastly_backends
    content {
      address               = backend.value.address
      auto_loadbalance      = backend.value.auto_loadbalance
      between_bytes_timeout = backend.value.between_bytes_timeout
      connect_timeout       = backend.value.connect_timeout
      error_threshold       = backend.value.error_threshold
      first_byte_timeout    = backend.value.first_byte_timeout
      healthcheck           = backend.value.healthcheck
      keepalive_time        = backend.value.keepalive_time
      max_conn              = backend.value.max_conn
      max_tls_version       = backend.value.max_tls_version
      min_tls_version       = backend.value.min_tls_version
      name                  = backend.value.name
      override_host         = backend.value.override_host
      port                  = backend.value.port
      request_condition     = backend.value.request_condition
      share_key             = backend.value.share_key
      shield                = backend.value.shield
      ssl_ca_cert           = backend.value.ssl_ca_cert
      ssl_cert_hostname     = backend.value.ssl_cert_hostname
      ssl_check_cert        = backend.value.ssl_check_cert
      ssl_ciphers           = backend.value.ssl_ciphers
      ssl_client_cert       = backend.value.ssl_client_cert
      ssl_client_key        = backend.value.ssl_client_key
      ssl_sni_hostname      = backend.value.ssl_sni_hostname
      use_ssl               = backend.value.use_ssl
      weight                = backend.value.weight
    }
  }

  dynamic "cache_setting" {
    for_each = var.fastly_cache_setting
    content {
      action          = cache_setting.value.action
      cache_condition = cache_setting.value.cache_condition
      name            = cache_setting.value.name
      stale_ttl       = cache_setting.value.stale_ttl
      ttl             = cache_setting.value.ttl
    }
  }

  dynamic "condition" {
    for_each = var.fastly_conditions
    content {
      name      = condition.value.name
      priority  = condition.value.priority
      statement = condition.value.statement
      type      = condition.value.type
    }
  }

  dynamic "dictionary" {
    for_each = var.fastly_dictionaries
    content {
      name = dictionary.value.name
    }
  }

  dynamic "director" {
    for_each = var.fastly_directors
    content {
      backends = director.value.backends
      comment  = director.value.comment
      name     = director.value.name
      quorum   = director.value.quorum
      retries  = director.value.retries
      shield   = director.value.shield
      type     = director.value.type
    }
  }

  dynamic "domain" {
    for_each = var.fastly_domain_names
    content {
      comment = domain.value.comment
      name    = domain.value.name
    }
  }

  dynamic "dynamicsnippet" {
    for_each = var.fastly_dynamic_snippets
    content {
      name     = dynamicsnippet.value.name
      priority = dynamicsnippet.value.priority
      type     = dynamicsnippet.value.type
    }
  }

  dynamic "gzip" {
    for_each = var.fastly_gzip_settings
    content {
      cache_condition = gzip.value.cache_condition
      content_types   = gzip.value.content_types
      extensions      = gzip.value.extensions
      name            = gzip.value.name
    }
  }

  dynamic "header" {
    for_each = var.fastly_headers
    content {
      action             = header.value.action
      cache_condition    = header.value.cache_condition
      destination        = header.value.destination
      ignore_if_set      = header.value.ignore_if_set
      name               = header.value.name
      priority           = header.value.priority
      regex              = header.value.regex
      request_condition  = header.value.request_condition
      response_condition = header.value.response_condition
      source             = header.value.source
      substitution       = header.value.substitution
      type               = header.value.type
    }
  }

  dynamic "healthcheck" {
    for_each = var.fastly_healthchecks
    content {
      check_interval    = healthcheck.value.check_interval
      expected_response = healthcheck.value.expected_response
      headers           = healthcheck.value.headers
      host              = healthcheck.value.host
      http_version      = healthcheck.value.http_version
      initial           = healthcheck.value.initial
      method            = healthcheck.value.method
      name              = healthcheck.value.name
      path              = healthcheck.value.path
      threshold         = healthcheck.value.threshold
      timeout           = healthcheck.value.timeout
      window            = healthcheck.value.window
    }
  }

  dynamic "image_optimizer_default_settings" {
    for_each = var.fastly_image_optimizers
    content {
      allow_video   = image_optimizer_default_settings.value.allow_video
      jpeg_quality  = image_optimizer_default_settings.value.jpeg_quality
      jpeg_type     = image_optimizer_default_settings.value.jpeg_type
      name          = image_optimizer_default_settings.value.name
      resize_filter = image_optimizer_default_settings.value.resize_filter
      upscale       = image_optimizer_default_settings.value.upscale
      webp          = image_optimizer_default_settings.value.webp
      webp_quality  = image_optimizer_default_settings.value.webp_quality
    }
  }

  dynamic "logging_bigquery" {
    for_each = var.fastly_logging_bigquery
    content {
      account_name       = logging_bigquery.value.account_name
      dataset            = logging_bigquery.value.dataset
      email              = var.fastly_logging_bigquery_email
      format             = logging_bigquery.value.format
      name               = logging_bigquery.value.name
      placement          = logging_bigquery.value.placement
      project_id         = logging_bigquery.value.project_id
      response_condition = logging_bigquery.value.response_condition
      secret_key         = var.fastly_logging_bigquery_secret_key
      table              = logging_bigquery.value.table
      template           = logging_bigquery.value.template
    }
  }

  dynamic "logging_blobstorage" {
    for_each = var.fastly_logging_blobstorage
    content {
      account_name       = logging_blobstorage.value.account_name
      compression_codec  = logging_blobstorage.value.compression_codec
      container          = logging_blobstorage.value.container
      file_max_bytes     = logging_blobstorage.value.file_max_bytes
      format             = logging_blobstorage.value.format
      format_version     = logging_blobstorage.value.format_version
      gzip_level         = logging_blobstorage.value.gzip_level
      message_type       = logging_blobstorage.value.message_type
      name               = logging_blobstorage.value.name
      path               = logging_blobstorage.value.path
      period             = logging_blobstorage.value.period
      placement          = logging_blobstorage.value.placement
      public_key         = logging_blobstorage.value.public_key
      response_condition = logging_blobstorage.value.response_condition
      sas_token          = var.fastly_logging_blobstorage_sas_token
      timestamp_format   = logging_blobstorage.value.timestamp_format
    }
  }

  dynamic "logging_cloudfiles" {
    for_each = var.fastly_logging_cloudfiles
    content {
      access_key         = var.fastly_logging_cloudfiles_access_key
      bucket_name        = logging_cloudfiles.value.bucket_name
      compression_codec  = logging_cloudfiles.value.compression_codec
      format             = logging_cloudfiles.value.format
      format_version     = logging_cloudfiles.value.format_version
      gzip_level         = logging_cloudfiles.value.gzip_level
      message_type       = logging_cloudfiles.value.message_type
      name               = logging_cloudfiles.value.name
      path               = logging_cloudfiles.value.path
      period             = logging_cloudfiles.value.period
      placement          = logging_cloudfiles.value.placement
      public_key         = logging_cloudfiles.value.public_key
      region             = logging_cloudfiles.value.region
      response_condition = logging_cloudfiles.value.response_condition
      timestamp_format   = logging_cloudfiles.value.timestamp_format
      user               = logging_cloudfiles.value.user
    }
  }

  dynamic "logging_datadog" {
    for_each = var.fastly_logging_datadog
    content {
      format             = logging_datadog.value.format
      format_version     = logging_datadog.value.format_version
      name               = logging_datadog.value.name
      placement          = logging_datadog.value.placement
      region             = logging_datadog.value.region
      response_condition = logging_datadog.value.response_condition
      token              = var.fastly_logging_datadog_token
    }
  }

  dynamic "logging_digitalocean" {
    for_each = var.fastly_logging_digitalocean
    content {
      access_key         = var.fastly_logging_digitalocean_access_key
      bucket_name        = logging_digitalocean.value.bucket_name
      compression_codec  = logging_digitalocean.value.compression_codec
      domain             = logging_digitalocean.value.domain
      format             = logging_digitalocean.value.format
      format_version     = logging_digitalocean.value.format_version
      gzip_level         = logging_digitalocean.value.gzip_level
      message_type       = logging_digitalocean.value.message_type
      name               = logging_digitalocean.value.name
      path               = logging_digitalocean.value.path
      period             = logging_digitalocean.value.period
      placement          = logging_digitalocean.value.placement
      public_key         = logging_digitalocean.value.public_key
      response_condition = logging_digitalocean.value.response_condition
      secret_key         = var.fastly_logging_digitalocean_secret_key
      timestamp_format   = logging_digitalocean.value.timestamp_format
    }
  }

  dynamic "logging_elasticsearch" {
    for_each = var.fastly_logging_elasticsearch
    content {
      format              = logging_elasticsearch.value.format
      format_version      = logging_elasticsearch.value.format_version
      index               = logging_elasticsearch.value.index
      name                = logging_elasticsearch.value.name
      password            = var.fastly_logging_elasticsearch_password
      pipeline            = logging_elasticsearch.value.pipeline
      placement           = logging_elasticsearch.value.placement
      request_max_bytes   = logging_elasticsearch.value.request_max_bytes
      request_max_entries = logging_elasticsearch.value.request_max_entries
      response_condition  = logging_elasticsearch.value.response_condition
      tls_ca_cert         = logging_elasticsearch.value.tls_ca_cert
      tls_client_cert     = logging_elasticsearch.value.tls_client_cert
      tls_client_key      = var.fastly_logging_elasticsearch_tls_client_key
      tls_hostname        = logging_elasticsearch.value.tls_hostname
      url                 = logging_elasticsearch.value.url
      user                = logging_elasticsearch.value.user
    }
  }

  dynamic "logging_ftp" {
    for_each = var.fastly_logging_ftp
    content {
      address            = logging_ftp.value.address
      compression_codec  = logging_ftp.value.compression_codec
      format             = logging_ftp.value.format
      format_version     = logging_ftp.value.format_version
      gzip_level         = logging_ftp.value.gzip_level
      message_type       = logging_ftp.value.message_type
      name               = logging_ftp.value.name
      password           = var.fastly_logging_ftp_password
      path               = logging_ftp.value.path
      period             = logging_ftp.value.period
      placement          = logging_ftp.value.placement
      port               = logging_ftp.value.port
      public_key         = logging_ftp.value.public_key
      response_condition = logging_ftp.value.response_condition
      timestamp_format   = logging_ftp.value.timestamp_format
      user               = logging_ftp.value.user
    }
  }

  dynamic "logging_gcs" {
    for_each = var.fastly_logging_gcs
    content {
      account_name       = logging_gcs.value.account_name
      bucket_name        = logging_gcs.value.bucket_name
      compression_codec  = logging_gcs.value.compression_codec
      format             = logging_gcs.value.format
      format_version     = logging_gcs.value.format_version
      gzip_level         = logging_gcs.value.gzip_level
      message_type       = logging_gcs.value.message_type
      name               = logging_gcs.value.name
      path               = logging_gcs.value.path
      period             = logging_gcs.value.period
      placement          = logging_gcs.value.placement
      project_id         = logging_gcs.value.project_id
      response_condition = logging_gcs.value.response_condition
      secret_key         = var.fastly_logging_gcs_secret_key
      timestamp_format   = logging_gcs.value.timestamp_format
    }
  }

  dynamic "logging_googlepubsub" {
    for_each = var.fastly_logging_googlepubsub
    content {
      account_name       = logging_googlepubsub.value.account_name
      format             = logging_googlepubsub.value.format
      format_version     = logging_googlepubsub.value.format_version
      name               = logging_googlepubsub.value.name
      placement          = logging_googlepubsub.value.placement
      project_id         = logging_googlepubsub.value.project_id
      response_condition = logging_googlepubsub.value.response_condition
      secret_key         = var.fastly_logging_googlepubsub_secret_key
      topic              = logging_googlepubsub.value.topic
      user               = logging_googlepubsub.value.user
    }
  }

  dynamic "logging_grafanacloudlogs" {
    for_each = var.fastly_logging_grafanacloudlogs
    content {
      format             = logging_grafanacloudlogs.value.format
      format_version     = logging_grafanacloudlogs.value.format_version
      index              = logging_grafanacloudlogs.value.index
      name               = logging_grafanacloudlogs.value.name
      placement          = logging_grafanacloudlogs.value.placement
      response_condition = logging_grafanacloudlogs.value.response_condition
      token              = var.fastly_logging_grafanacloudlogs_token
      url                = logging_grafanacloudlogs.value.url
      user               = logging_grafanacloudlogs.value.user
    }
  }

  dynamic "logging_heroku" {
    for_each = var.fastly_logging_heroku
    content {
      format             = logging_heroku.value.format
      format_version     = logging_heroku.value.format_version
      name               = logging_heroku.value.name
      placement          = logging_heroku.value.placement
      response_condition = logging_heroku.value.response_condition
      token              = var.fastly_logging_heroku_token
      url                = logging_heroku.value.url
    }
  }

  dynamic "logging_honeycomb" {
    for_each = var.fastly_logging_honeycomb
    content {
      dataset            = logging_honeycomb.value.dataset
      format             = logging_honeycomb.value.format
      format_version     = logging_honeycomb.value.format_version
      name               = logging_honeycomb.value.name
      placement          = logging_honeycomb.value.placement
      response_condition = logging_honeycomb.value.response_condition
      token              = var.fastly_logging_honeycomb_token
    }
  }

  dynamic "logging_https" {
    for_each = var.fastly_logging_https
    content {
      content_type        = logging_https.value.content_type
      format              = logging_https.value.format
      format_version      = logging_https.value.format_version
      header_name         = logging_https.value.header_name
      header_value        = logging_https.value.header_value
      json_format         = logging_https.value.json_format
      message_type        = logging_https.value.message_type
      method              = logging_https.value.method
      name                = logging_https.value.name
      placement           = logging_https.value.placement
      request_max_bytes   = logging_https.value.request_max_bytes
      request_max_entries = logging_https.value.request_max_entries
      response_condition  = logging_https.value.response_condition
      tls_ca_cert         = logging_https.value.tls_ca_cert
      tls_client_cert     = logging_https.value.tls_client_cert
      tls_client_key      = var.fastly_logging_https_tls_client_key
      tls_hostname        = logging_https.value.tls_hostname
      url                 = logging_https.value.url
    }
  }

  dynamic "logging_kafka" {
    for_each = var.fastly_logging_kafka
    content {
      auth_method        = logging_kafka.value.auth_method
      brokers            = logging_kafka.value.brokers
      compression_codec  = logging_kafka.value.compression_codec
      format             = logging_kafka.value.format
      format_version     = logging_kafka.value.format_version
      name               = logging_kafka.value.name
      parse_log_keyvals  = logging_kafka.value.parse_log_keyvals
      password           = var.fastly_logging_kafka_password
      placement          = logging_kafka.value.placement
      request_max_bytes  = logging_kafka.value.request_max_bytes
      required_acks      = logging_kafka.value.required_acks
      response_condition = logging_kafka.value.response_condition
      tls_ca_cert        = logging_kafka.value.tls_ca_cert
      tls_client_cert    = logging_kafka.value.tls_client_cert
      tls_client_key     = var.fastly_logging_kafka_tls_client_key
      tls_hostname       = logging_kafka.value.tls_hostname
      topic              = logging_kafka.value.topic
      use_tls            = logging_kafka.value.use_tls
      user               = logging_kafka.value.user
    }
  }

  dynamic "logging_kinesis" {
    for_each = var.fastly_logging_kinesis
    content {
      access_key         = var.fastly_logging_kinesis_access_key
      format             = logging_kinesis.value.format
      format_version     = logging_kinesis.value.format_version
      iam_role           = logging_kinesis.value.iam_role
      name               = logging_kinesis.value.name
      placement          = logging_kinesis.value.placement
      region             = logging_kinesis.value.region
      response_condition = logging_kinesis.value.response_condition
      secret_key         = var.fastly_logging_kinesis_secret_key
      topic              = logging_kinesis.value.topic
    }
  }

  dynamic "logging_logentries" {
    for_each = var.fastly_logging_logentries
    content {
      format             = logging_logentries.value.format
      format_version     = logging_logentries.value.format_version
      name               = logging_logentries.value.name
      placement          = logging_logentries.value.placement
      port               = logging_logentries.value.port
      response_condition = logging_logentries.value.response_condition
      token              = var.fastly_logging_logentries_token
      use_tls            = logging_logentries.value.use_tls
    }
  }

  dynamic "logging_loggly" {
    for_each = var.fastly_logging_loggly
    content {
      format             = logging_loggly.value.format
      format_version     = logging_loggly.value.format_version
      name               = logging_loggly.value.name
      placement          = logging_loggly.value.placement
      response_condition = logging_loggly.value.response_condition
      token              = var.fastly_logging_loggly_token
    }
  }

  dynamic "logging_logshuttle" {
    for_each = var.fastly_logging_logshuttle
    content {
      format             = logging_logshuttle.value.format
      format_version     = logging_logshuttle.value.format_version
      name               = logging_logshuttle.value.name
      placement          = logging_logshuttle.value.placement
      response_condition = logging_logshuttle.value.response_condition
      token              = var.fastly_logging_logshuttle_token
      url                = logging_logshuttle.value.url
    }
  }

  dynamic "logging_newrelic" {
    for_each = var.fastly_logging_newrelic
    content {
      format             = logging_newrelic.value.format
      format_version     = logging_newrelic.value.format_version
      name               = logging_newrelic.value.name
      placement          = logging_newrelic.value.placement
      region             = logging_newrelic.value.region
      response_condition = logging_newrelic.value.response_condition
      token              = var.fastly_logging_newrelic_token
    }
  }

  dynamic "logging_newrelicotlp" {
    for_each = var.fastly_logging_newrelicotlp
    content {
      format             = logging_newrelicotlp.value.format
      format_version     = logging_newrelicotlp.value.format_version
      name               = logging_newrelicotlp.value.name
      placement          = logging_newrelicotlp.value.placement
      region             = logging_newrelicotlp.value.region
      response_condition = logging_newrelicotlp.value.response_condition
      token              = var.fastly_logging_newrelicotlp_token
      url                = logging_newrelicotlp.value.url
    }
  }

  dynamic "logging_openstack" {
    for_each = var.fastly_logging_openstack
    content {
      access_key         = var.fastly_logging_openstack_access_key
      bucket_name        = logging_openstack.value.bucket_name
      compression_codec  = logging_openstack.value.compression_codec
      format             = logging_openstack.value.format
      format_version     = logging_openstack.value.format_version
      gzip_level         = logging_openstack.value.gzip_level
      message_type       = logging_openstack.value.message_type
      name               = logging_openstack.value.name
      path               = logging_openstack.value.path
      period             = logging_openstack.value.period
      placement          = logging_openstack.value.placement
      public_key         = logging_openstack.value.public_key
      response_condition = logging_openstack.value.response_condition
      timestamp_format   = logging_openstack.value.timestamp_format
      url                = logging_openstack.value.url
      user               = logging_openstack.value.user
    }
  }

  dynamic "logging_papertrail" {
    for_each = var.fastly_logging_papertrail
    content {
      address            = logging_papertrail.value.address
      format             = logging_papertrail.value.format
      format_version     = logging_papertrail.value.format_version
      name               = logging_papertrail.value.name
      placement          = logging_papertrail.value.placement
      port               = logging_papertrail.value.port
      response_condition = logging_papertrail.value.response_condition
    }
  }

  dynamic "logging_s3" {
    for_each = var.fastly_logging_s3
    content {
      acl                               = logging_s3.value.acl
      bucket_name                       = logging_s3.value.bucket_name
      compression_codec                 = logging_s3.value.compression_codec
      domain                            = logging_s3.value.domain
      file_max_bytes                    = logging_s3.value.file_max_bytes
      format                            = logging_s3.value.format
      format_version                    = logging_s3.value.format_version
      gzip_level                        = logging_s3.value.gzip_level
      message_type                      = logging_s3.value.message_type
      name                              = logging_s3.value.name
      path                              = logging_s3.value.path
      period                            = logging_s3.value.period
      placement                         = logging_s3.value.placement
      public_key                        = logging_s3.value.public_key
      redundancy                        = logging_s3.value.redundancy
      response_condition                = logging_s3.value.response_condition
      s3_access_key                     = var.fastly_logging_s3_access_key
      s3_iam_role                       = logging_s3.value.s3_iam_role
      s3_secret_key                     = var.fastly_logging_s3_secret_key
      server_side_encryption            = logging_s3.value.server_side_encryption
      server_side_encryption_kms_key_id = logging_s3.value.server_side_encryption_kms_key_id
      timestamp_format                  = logging_s3.value.timestamp_format
    }
  }

  dynamic "logging_scalyr" {
    for_each = var.fastly_logging_scalyr
    content {
      format             = logging_scalyr.value.format
      format_version     = logging_scalyr.value.format_version
      name               = logging_scalyr.value.name
      placement          = logging_scalyr.value.placement
      project_id         = logging_scalyr.value.project_id
      region             = logging_scalyr.value.region
      response_condition = logging_scalyr.value.response_condition
      token              = var.fastly_logging_scalyr_token
    }
  }

  dynamic "logging_sftp" {
    for_each = var.fastly_logging_sftp
    content {
      address            = logging_sftp.value.address
      compression_codec  = logging_sftp.value.compression_codec
      format             = logging_sftp.value.format
      format_version     = logging_sftp.value.format_version
      gzip_level         = logging_sftp.value.gzip_level
      message_type       = logging_sftp.value.message_type
      name               = logging_sftp.value.name
      password           = var.fastly_logging_sftp_password
      path               = logging_sftp.value.path
      period             = logging_sftp.value.period
      placement          = logging_sftp.value.placement
      port               = logging_sftp.value.port
      public_key         = logging_sftp.value.public_key
      response_condition = logging_sftp.value.response_condition
      secret_key         = var.fastly_logging_sftp_secret_key
      ssh_known_hosts    = logging_sftp.value.ssh_known_hosts
      timestamp_format   = logging_sftp.value.timestamp_format
      user               = logging_sftp.value.user
    }
  }

  dynamic "logging_splunk" {
    for_each = var.fastly_logging_splunk
    content {
      format             = logging_splunk.value.format
      format_version     = logging_splunk.value.format_version
      name               = logging_splunk.value.name
      placement          = logging_splunk.value.placement
      response_condition = logging_splunk.value.response_condition
      tls_ca_cert        = logging_splunk.value.tls_ca_cert
      tls_client_cert    = logging_splunk.value.tls_client_cert
      tls_client_key     = var.fastly_logging_splunk_tls_client_key
      tls_hostname       = logging_splunk.value.tls_hostname
      token              = var.fastly_logging_splunk_token
      url                = logging_splunk.value.url
      use_tls            = logging_splunk.value.use_tls
    }
  }

  dynamic "logging_sumologic" {
    for_each = var.fastly_logging_sumologic
    content {
      format             = logging_sumologic.value.format
      format_version     = logging_sumologic.value.format_version
      message_type       = logging_sumologic.value.message_type
      name               = logging_sumologic.value.name
      placement          = logging_sumologic.value.placement
      response_condition = logging_sumologic.value.response_condition
      url                = logging_sumologic.value.url
    }
  }

  dynamic "logging_syslog" {
    for_each = var.fastly_logging_syslog
    content {
      address            = logging_syslog.value.address
      format             = logging_syslog.value.format
      format_version     = logging_syslog.value.format_version
      message_type       = logging_syslog.value.message_type
      name               = logging_syslog.value.name
      placement          = logging_syslog.value.placement
      port               = logging_syslog.value.port
      response_condition = logging_syslog.value.response_condition
      tls_ca_cert        = logging_syslog.value.tls_ca_cert
      tls_client_cert    = logging_syslog.value.tls_client_cert
      tls_client_key     = var.fastly_logging_syslog_tls_client_key
      tls_hostname       = logging_syslog.value.tls_hostname
      token              = logging_syslog.value.token
      use_tls            = logging_syslog.value.use_tls
    }
  }

  dynamic "product_enablement" {
    for_each = var.fastly_product_enablement
    content {
      bot_management     = product_enablement.value.bot_management
      brotli_compression = product_enablement.value.brotli_compression
      dynamic "ddos_protection" {
        for_each = product_enablement.value.ddos_protection != null ? [product_enablement.value.ddos_protection] : []
        content {
          enabled = ddos_protection.value.enabled
          mode    = ddos_protection.value.mode
        }
      }
      domain_inspector      = product_enablement.value.domain_inspector
      image_optimizer       = product_enablement.value.image_optimizer
      log_explorer_insights = product_enablement.value.log_explorer_insights
      name                  = product_enablement.value.name
      dynamic "ngwaf" {
        for_each = product_enablement.value.ngwaf != null ? [product_enablement.value.ngwaf] : []
        content {
          enabled      = ngwaf.value.enabled
          traffic_ramp = ngwaf.value.traffic_ramp
          workspace_id = ngwaf.value.workspace_id
        }
      }
      origin_inspector = product_enablement.value.origin_inspector
      websockets       = product_enablement.value.websockets
    }
  }

  dynamic "rate_limiter" {
    for_each = var.fastly_rate_limiters
    content {
      action               = rate_limiter.value.action
      client_key           = rate_limiter.value.client_key
      feature_revision     = rate_limiter.value.feature_revision
      http_methods         = rate_limiter.value.http_methods
      logger_type          = rate_limiter.value.action == "log_only" ? rate_limiter.value.logger_type : null
      name                 = "${var.fastly_domain_names[0].name} Rate Limit - ${rate_limiter.value.name_suffix}"
      penalty_box_duration = rate_limiter.value.penalty_box_duration
      dynamic "response" {
        for_each = rate_limiter.value.action == "response" ? [rate_limiter.value.response] : []
        content {
          content      = response.value.content
          content_type = response.value.content_type
          status       = response.value.status
        }
      }
      response_object_name = rate_limiter.value.response_object_name
      rps_limit            = rate_limiter.value.rps_limit
      uri_dictionary_name  = rate_limiter.value.uri_dictionary_name
      window_size          = rate_limiter.value.window_size
    }
  }

  dynamic "request_setting" {
    for_each = var.fastly_request_settings
    content {
      action            = request_setting.value.action
      bypass_busy_wait  = request_setting.value.bypass_busy_wait
      default_host      = request_setting.value.default_host
      force_miss        = request_setting.value.force_miss
      force_ssl         = request_setting.value.force_ssl
      hash_keys         = request_setting.value.hash_keys
      max_stale_age     = request_setting.value.max_stale_age
      name              = request_setting.value.name
      request_condition = request_setting.value.request_condition
      timer_support     = request_setting.value.timer_support
      xff               = request_setting.value.xff
    }
  }

  dynamic "response_object" {
    for_each = var.fastly_response_objects
    content {
      cache_condition   = response_object.value.cache_condition
      content           = response_object.value.content
      content_type      = response_object.value.content_type
      name              = response_object.value.name
      request_condition = response_object.value.request_condition
      response          = response_object.value.response
      status            = response_object.value.status
    }
  }

  dynamic "snippet" {
    for_each = var.fastly_snippets

    content {
      content  = snippet.value.content
      name     = snippet.value.name
      priority = snippet.value.priority
      type     = snippet.value.type
    }
  }
}

resource "fastly_service_acl_entries" "this" {
  for_each = {
    for e in fastly_service_vcl.this.acl : e.name => e
  }

  acl_id         = each.value.acl_id
  manage_entries = { for e in var.fastly_acls : e.name => e }[each.value.name].manage_entries
  service_id     = fastly_service_vcl.this.id
  dynamic "entry" {
    for_each = { for e in var.fastly_acls : e.name => e }[each.value.name].entries

    content {
      comment = entry.value.comment
      ip      = entry.value.ip
      negated = entry.value.negated
      subnet  = entry.value.subnet
    }
  }
}

resource "fastly_service_dictionary_items" "this" {
  for_each = {
    for i in fastly_service_vcl.this.dictionary : i.name => i
  }

  service_id    = fastly_service_vcl.this.id
  dictionary_id = each.value.dictionary_id
  manage_items  = { for i in var.fastly_dictionaries : i.name => i }[each.value.name].manage_items
  items         = { for i in var.fastly_dictionaries : i.name => i }[each.value.name].items
}


locals {
  dynamic_snippets_map = {
    for d in var.fastly_dynamic_snippets : d.name => d
  }
}
resource "fastly_service_dynamic_snippet_content" "this" {
  for_each = {
    for c in fastly_service_vcl.this.dynamicsnippet : c.name => c if
    lookup(
      lookup(local.dynamic_snippets_map, c.name, {}),
      "content", null
    ) != null
  }

  service_id      = fastly_service_vcl.this.id
  snippet_id      = each.value.snippet_id
  manage_snippets = local.dynamic_snippets_map[each.value.name].manage
  content         = local.dynamic_snippets_map[each.value.name].content
}
