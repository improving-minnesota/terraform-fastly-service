# Logging BigQuery
variable "fastly_logging_bigquery_email" {
  default     = ""
  description = "(String, Sensitive) The email for the service account with write access to your BigQuery dataset. If not provided, this will be pulled from a FASTLY_BQ_EMAIL environment variable."
  sensitive   = true
  type        = string
}

variable "fastly_logging_bigquery_secret_key" {
  default     = ""
  description = " (String, Sensitive) The secret key associated with the service account that has write access to your BigQuery table. If not provided, this will be pulled from the FASTLY_BQ_SECRET_KEY environment variable. Typical format for this is a private key in a string with newlines."
  sensitive   = true
  type        = string
}

variable "fastly_logging_bigquery" {
  description = <<EOF
  A list of logging BigQuery settings to be added to the Fastly service. Each object in the list has the following attributes:
  - account_name (String) The google account name used to obtain temporary credentials (default none). You may optionally provide this via an environment variable, FASTLY_GCS_ACCOUNT_NAME.
  - dataset (String) The ID of your BigQuery dataset.
  - format (String) The logging format desired.
  - name (String) A unique name to identify this BigQuery logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - placement (String) Where in the generated VCL the logging call should be placed.
  - project_id (String) The ID of your GCP project.
  - response_condition (String) Name of a condition to apply this logging.
  - table (String) The ID of your BigQuery table.
  - template (String) BigQuery table name suffix template.
  EOF
  type = list(object({
    account_name       = optional(string)
    dataset            = string
    format             = optional(string)
    name               = string
    placement          = optional(string)
    project_id         = string
    response_condition = optional(string)
    table              = string
    template           = optional(string)
  }))
  default = []
}

# Logging Azure Blob Storage
variable "fastly_logging_blobstorage_sas_token" {
  default     = ""
  description = "(String, Sensitive) The Azure shared access signature providing write access to the blob service objects. Be sure to update your token before it expires or the logging functionality will not work."
  sensitive   = true
  type        = string
}

variable "fastly_logging_blobstorage" {
  description = <<EOF
  A list of logging Azure Blob Storage settings to be added to the Fastly service. Each object in the list has the following attributes:
  - account_name (String) The unique Azure Blob Storage namespace in which your data objects are stored.
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - container (String) The name of the Azure Blob Storage container in which to store logs.
  - file_max_bytes (String) Maximum size of an uploaded log file, if non-zero.
  - format (String) Apache-style string or VCL variables to use for log formatting Default: %h %l %u %t "%r" %>s %b
  - format_version (String) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - gzip_level (String) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) A unique name to identify the Azure Blob Storage endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - path (String) The path to upload logs to. Must end with a trailing slash. If this field is left empty, the files will be saved in the container's root path.
  - period (String) How frequently the logs should be transferred in seconds. Default 3600.
  - placement (String) Where in the generated VCL the logging call should be placed.
  - public_key (String) A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
  - response_condition (String) The name of the condition to apply.
  - timestamp_format (String) The strftime specified timestamp formatting. Default: %Y-%m-%dT%H:%M:%S.000
  EOF
  type = list(object({
    account_name       = string
    compression_codec  = optional(string)
    container          = string
    file_max_bytes     = optional(number)
    format             = string
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = optional(string)
    period             = optional(number)
    placement          = optional(string)
    public_key         = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
  }))
  default = []
}

# Logging Cloud Files
variable "fastly_logging_cloudfiles_access_key" {
  default     = ""
  description = "(String, Sensitive) Your Cloud File account access key."
  sensitive   = true
  type        = string
}

variable "fastly_logging_cloudfiles" {
  description = <<EOF
  A list of logging Cloud Files settings to be added to the Fastly service. Each object in the list has the following attributes:
  - bucket_name (String) The name of your Cloud Files container.
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the Rackspace Cloud Files logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - path (String) The path to upload logs to.
  - period (Number) How frequently log files are finalized so they can be available for reading in seconds. Default 3600
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - public_key (String) The PGP public key that Fastly will use to encrypt your log files before writing them to disk.
  - region (String) The region to stream logs to. One of: DFW (Dallas), ORD (Chicago), IAD (Northern Virginia), LON (London), SYD (Sydney), HKG (Hong Kong).
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - timestamp_format (String) The strftime specified timestamp formatting. Default: %Y-%m-%dT%H:%M:%S.000
  - user (String) The username for your Cloud Files account.
  EOF
  type = list(object({
    bucket_name        = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = optional(string)
    period             = optional(number)
    placement          = optional(string)
    public_key         = optional(string)
    region             = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
    user               = string
  }))
  default = []
}

# Logging Datadog
variable "fastly_logging_datadog_token" {
  default     = ""
  description = "(String, Sensitive) The API key from your Datadog account."
  sensitive   = true
  type        = string
}

variable "fastly_logging_datadog" {
  description = <<EOF
  A list of logging Datadog settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - name (String) The unique name of the Datadog logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - placement (String) Where in the generated VCL the logging call should be placed.
  - region (String) The region that log data will be sent to. One of US or EU. Default US
  - response_condition (String) The name of the condition to apply.
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    region             = optional(string)
    response_condition = optional(string)
  }))
  default = []
}

# Logging DigitalOcean
variable "fastly_logging_digitalocean_access_key" {
  default     = ""
  description = "(String, Sensitive) Your DigitalOcean Spaces account access key."
  sensitive   = true
  type        = string
}

variable "fastly_logging_digitalocean_secret_key" {
  default     = ""
  description = "(String, Sensitive) Your DigitalOcean Spaces account secret key."
  sensitive   = true
  type        = string
}

variable "fastly_logging_digitalocean" {
  description = <<EOF
  A list of logging DigitalOcean settings to be added to the Fastly service. Each object in the list has the following attributes:
  - bucket_name (String) The name of the DigitalOcean Space.
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - domain (String) The domain of the DigitalOcean Spaces endpoint Default: nyc3.digitaloceanspaces.com
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the DigitalOcean Spaces logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - path (String) The path to upload logs to.
  - period (Number) How frequently log files are finalized so they can be available for reading in seconds. Default 3600
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - public_key (String) A PGP public key that Fastly will use to encrypt your log files before writing them to disk.
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - timestamp_format (String) The strftime specified timestamp formatting Default: %Y-%m-%dT%H:%M:%S.000
  EOF
  type = list(object({
    bucket_name        = string
    compression_codec  = optional(string)
    domain             = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = optional(string)
    period             = optional(number)
    placement          = optional(string)
    public_key         = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
  }))
  default = []
}

# Logging Elasticsearch
variable "fastly_logging_elasticsearch_password" {
  default     = ""
  description = "(String, Sensitive) BasicAuth password for Elasticsearch."
  sensitive   = true
  type        = string
}

variable "fastly_logging_elasticsearch_tls_client_key" {
  default     = ""
  description = " (String, Sensitive) The client private key used to make authenticated requests. Must be in PEM format."
  sensitive   = true
  type        = string
}

variable "fastly_logging_elasticsearch" {
  description = <<EOF
  A list of logging Elasticsearch settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - index (String) The name of the Elasticsearch index to send documents (logs) to.
  - name (String) The unique name of the Elasticsearch logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - pipeline (String) The ID of the Elasticsearch ingest pipeline to apply pre-process transformations to before indexing.
  - placement (String) Where in the generated VCL the logging call should be placed.
  - request_max_bytes (Number) The maximum number of logs sent in one request. Defaults to 0 for unbounded.
  - request_max_entries (Number) The maximum number of bytes sent in one request. Defaults to 0 for unbounded.
  - response_condition (String) The name of the condition to apply.
  - tls_ca_cert (String) secure certificate to authenticate the server with. Must be in PEM format.
  - tls_client_cert (String) The client certificate used to make authenticated requests. Must be in PEM format.
  - tls_hostname (String) The hostname used to verify the server's certificate. It can either be the Common Name (CN) or a Subject Alternative Name (SAN).
  - url (String) The Elasticsearch URL to stream logs to.
  - user (String) BasicAuth username for Elasticsearch.
  EOF
  type = list(object({
    format              = optional(string)
    format_version      = optional(number)
    index               = string
    name                = string
    pipeline            = optional(string)
    placement           = optional(string)
    request_max_bytes   = optional(number)
    request_max_entries = optional(number)
    response_condition  = optional(string)
    tls_ca_cert         = optional(string)
    tls_client_cert     = optional(string)
    tls_hostname        = optional(string)
    url                 = string
    user                = optional(string)
  }))
  default = []
}

# Logging FTP
variable "fastly_logging_ftp_password" {
  default     = ""
  description = "(String, Sensitive) The password for the server (for anonymous use an email address)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_ftp" {
  description = <<EOF
  A list of logging FTP settings to be added to the Fastly service. Each object in the list has the following attributes:
  - address (String) The FTP address to stream logs to.
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. Default 2
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the FTP logging endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - path (String) The path to upload log files to. If the path ends in / then it is treated as a directory.
  - period (Number) How frequently the logs should be transferred, in seconds. Default 3600
  - placement (String) Where in the generated VCL the logging call should be placed.
  - port (Number) The port number. Default 21
  - public_key (String) The PGP public key that Fastly will use to encrypt your log files before writing them to disk.
  - response_condition (String) The name of the condition to apply.
  - timestamp_format (String) The strftime specified timestamp formatting. Default: %Y-%m-%dT%H:%M:%S.000
  - user (String) The username for the server (can be anonymous).
  EOF
  type = list(object({
    address            = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = string
    period             = optional(number)
    placement          = optional(string)
    port               = optional(number)
    public_key         = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
    user               = string
  }))
  default = []
}

# Logging GCS
variable "fastly_logging_gcs_secret_key" {
  default     = ""
  description = "(String, Sensitive) The secret key associated with the target gcs bucket on your account. You may optionally provide this secret via an environment variable, FASTLY_GCS_SECRET_KEY. A typical format for the key is PEM format, containing actual newline characters where required."
  sensitive   = true
  type        = string
}

variable "fastly_logging_gcs" {
  description = <<EOF
  A list of logging GCS settings to be added to the Fastly service. Each object in the list has the following attributes:
  - account_name (String) The google account name used to obtain temporary credentials (default none). You may optionally provide this via an environment variable, FASTLY_GCS_ACCOUNT_NAME.
  - bucket_name (String) The name of the bucket in which to store the logs
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - format (String) Apache-style string or VCL variables to use for log formatting
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (Default: 2)
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) A unique name to identify this GCS endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - path (String) Path to store the files. Must end with a trailing slash. If this field is left empty, the files will be saved in the bucket's root path
  - period (Number) How frequently the logs should be transferred, in seconds (Default 3600)
  - placement (String) Where in the generated VCL the logging call should be placed.
  - project_id (String) The ID of your Google Cloud Platform project
  - response_condition (String) Name of a condition to apply this logging.
  - secret_key (String, Sensitive) The secret key associated with the target gcs bucket on your account. You may optionally provide this secret via an environment variable, FASTLY_GCS_SECRET_KEY. A typical format for the key is PEM format, containing actual newline characters where required
  - timestamp_format (String) The strftime specified timestamp formatting (default %Y-%m-%dT%H:%M:%S.000)
  - user (String) Your Google Cloud Platform service account email address. The client_email field in your service account authentication JSON. You may optionally provide this via an environment variable, FASTLY_GCS_EMAIL.
  EOF
  type = list(object({
    account_name       = optional(string)
    bucket_name        = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = optional(string)
    period             = optional(number)
    placement          = optional(string)
    project_id         = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
    user               = optional(string)
  }))
  default = []
}

# Logging Google Cloud Pub/Sub
variable "fastly_logging_googlepubsub_secret_key" {
  default     = ""
  description = "(String, Sensitive) Your Google Cloud Platform account secret key. The private_key field in your service account authentication JSON. You may optionally provide this secret via an environment variable, FASTLY_GOOGLE_PUBSUB_SECRET_KEY."
  sensitive   = true
  type        = string
}

variable "fastly_logging_googlepubsub" {
  description = <<EOF
  A list of logging Google Cloud Pub/Sub settings to be added to the Fastly service. Each object in the list has the following attributes:
  - account_name (String) The google account name used to obtain temporary credentials (default none). You may optionally provide this via an environment variable, FASTLY_GCS_ACCOUNT_NAME.
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Google Cloud Pub/Sub logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - project_id (String) The ID of your Google Cloud Platform project
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - topic (String) The Google Cloud Pub/Sub topic to which logs will be published
  - user (String) Your Google Cloud Platform service account email address. The client_email field in your service account authentication JSON. You may optionally provide this via an environment variable, FASTLY_GOOGLE_PUBSUB_EMAIL.
  EOF
  type = list(object({
    account_name       = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    project_id         = string
    response_condition = optional(string)
    topic              = string
    user               = optional(string)
  }))
  default = []
}

# Logging GrafanaCloudLogs
variable "fastly_logging_grafanacloudlogs_token" {
  default     = ""
  description = "(String, Sensitive) The Access Policy Token key for your GrafanaCloudLogs account."
  sensitive   = true
  type        = string
}

variable "fastly_logging_grafanacloudlogs" {
  description = <<EOF
  A list of logging GrafanaCloudLogs settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - index (String) The stream identifier as a JSON string
  - name (String) The unique name of the GrafanaCloudLogs logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - response_condition (String) The name of the condition to apply.
  - token (String, Sensitive) The Access Policy Token key for your GrafanaCloudLogs account
  - url (String) The URL to stream logs to
  - user (String) The Grafana User ID
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    index              = string
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
    url                = string
    user               = string
  }))
  default = []
}

# Logging Heroku
variable "fastly_logging_heroku_token" {
  default     = ""
  description = "(String, Sensitive) The token to use for authentication (https://www.heroku.com/docs/customer-token-authentication-token/)"
  sensitive   = true
  type        = string
}

variable "fastly_logging_heroku" {
  description = <<EOF
  A list of logging Heroku settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Heroku logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - url (String) The URL to stream logs to
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
    url                = string
  }))
  default = []
}

# Logging Honeycomb
variable "fastly_logging_honeycomb_token" {
  default     = ""
  description = "(String, Sensitive) The Write Key from the Account page of your Honeycomb account."
  sensitive   = true
  type        = string
}

variable "fastly_logging_honeycomb" {
  description = <<EOF
  A list of logging Honeycomb settings to be added to the Fastly service. Each object in the list has the following attributes:
  - dataset (String) The Honeycomb Dataset you want to log to
  - format (String) Apache style log formatting. Your log must produce valid JSON that Honeycomb can ingest.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Honeycomb logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  EOF
  type = list(object({
    dataset            = string
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
  }))
  default = []
}

# Logging HTTPS
variable "fastly_logging_https_tls_client_key" {
  default     = ""
  description = "(String, Sensitive) The client private key used to make authenticated requests. Must be in PEM format."
  sensitive   = true
  type        = string
}

variable "fastly_logging_https" {
  description = <<EOF
  A list of logging HTTPS settings to be added to the Fastly service. Each object in the list has the following attributes:
  - content_type (String) Value of the Content-Type header sent with the request
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2)
  - header_name (String) Custom header sent with the request
  - header_value (String) Value of the custom header sent with the request
  - json_format (String) Formats log entries as JSON. Can be either disabled (0), array of json (1), or newline delimited json (2)
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - method (String) HTTP method used for request. Can be either POST or PUT. Default POST
  - name (String) The unique name of the HTTPS logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed
  - request_max_bytes (Number) The maximum number of bytes sent in one request
  - request_max_entries (Number) The maximum number of logs sent in one request
  - response_condition (String) The name of the condition to apply
  - tls_ca_cert (String) A secure certificate to authenticate the server with. Must be in PEM format
  - tls_client_cert (String) The client certificate used to make authenticated requests. Must be in PEM format
  - tls_hostname (String) Used during the TLS handshake to validate the certificate
  - url (String) URL that log data will be sent to. Must use the https protocol
  EOF
  type = list(object({
    content_type        = optional(string)
    format              = optional(string)
    format_version      = optional(number)
    header_name         = optional(string)
    header_value        = optional(string)
    json_format         = optional(number)
    message_type        = optional(string)
    method              = optional(string)
    name                = string
    placement           = optional(string)
    request_max_bytes   = optional(number)
    request_max_entries = optional(number)
    response_condition  = optional(string)
    tls_ca_cert         = optional(string)
    tls_client_cert     = optional(string)
    tls_hostname        = optional(string)
    url                 = string
  }))
  default = []
}

# Logging Kafka
variable "fastly_logging_kafka_password" {
  default     = ""
  description = "(String, Sensitive) SASL Password used to authenticate with the Kafka brokers."
  sensitive   = true
  type        = string
}

variable "fastly_logging_kafka_tls_client_key" {
  default     = ""
  description = "(String, Sensitive) The client private key used to make authenticated requests. Must be in PEM format."
  sensitive   = true
  type        = string
}

variable "fastly_logging_kafka" {
  description = <<EOF
  A list of logging Kafka settings to be added to the Fastly service. Each object in the list has the following attributes:
  - auth_method (String) SASL authentication method. One of: plain, scram-sha-256, scram-sha-512
  - brokers (String) A comma-separated list of IP addresses or hostnames of Kafka brokers
  - compression_codec (String) The codec used for compression of your logs. One of: gzip, snappy, lz4
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Kafka logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - parse_log_keyvals (Boolean) Enables parsing of key=value tuples from the beginning of a logline, turning them into record headers
  - placement (String) Where in the generated VCL the logging call should be placed.
  - request_max_bytes (Number) Maximum size of log batch, if non-zero. Defaults to 0 for unbounded
  - required_acks (String) The Number of acknowledgements a leader must receive before a write is considered successful. One of: 1 (default) One server needs to respond. 0 No servers need to respond. -1 Wait for all in-sync replicas to respond
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - tls_ca_cert (String) A secure certificate to authenticate the server with. Must be in PEM format
  - tls_client_cert (String) The client certificate used to make authenticated requests. Must be in PEM format
  - tls_hostname (String) The hostname used to verify the server's certificate. It can either be the Common Name or a Subject Alternative Name (SAN)
  - topic (String) The Kafka topic to send logs to
  - use_tls (Boolean) Whether to use TLS for secure logging. Can be either true or false
  - user (String) SASL User
  EOF
  type = list(object({
    auth_method        = optional(string)
    brokers            = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    parse_log_keyvals  = optional(bool)
    placement          = optional(string)
    request_max_bytes  = optional(number)
    required_acks      = optional(string)
    response_condition = optional(string)
    tls_ca_cert        = optional(string)
    tls_client_cert    = optional(string)
    tls_hostname       = optional(string)
    topic              = string
    use_tls            = optional(bool)
    user               = optional(string)
  }))
  default = []
}

# Logging Kinesis
variable "fastly_logging_kinesis_access_key" {
  default     = ""
  description = "(String, Sensitive) The AWS access key to be used to write to the stream (https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_kinesis_secret_key" {
  default     = ""
  description = "(String, Sensitive) The AWS secret access key to authenticate with (https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_kinesis" {
  description = <<EOF
  A list of logging Kinesis settings to be added to the Fastly service. Each object in the list has the following attributes:
  - access_key (String, Sensitive) The AWS access key to be used to write to the stream
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - iam_role (String) The Amazon Resource Name (ARN) for the IAM role granting Fastly access to Kinesis. Not required if access_key and secret_key are provided.
  - name (String) The unique name of the Kinesis logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - region (String) The AWS region the stream resides in. (Default: us-east-1)
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - secret_key (String, Sensitive) The AWS secret access key to authenticate with
  - topic (String) The Kinesis stream name
  EOF
  type = list(object({
    access_key         = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    iam_role           = optional(string)
    name               = string
    placement          = optional(string)
    region             = optional(string)
    response_condition = optional(string)
    topic              = string
  }))
  default = []
}

# Logging Logentries
variable "fastly_logging_logentries_token" {
  default     = ""
  description = "token (String) Use token based authentication (https://logentries.com/doc/input-token/)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_logentries" {
  description = <<EOF
  A list of logging Logentries settings to be added to the Fastly service. Each object in the list has the following attributes:
  - name (String) The unique name of the Logentries logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - format (String) Apache-style string or VCL variables to use for log formatting
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (Default: 2)
  - placement (String) Where in the generated VCL the logging call should be placed.
  - port (Number) The port number configured in Logentries
  - response_condition (String) Name of blockAttributes condition to apply this logging.
  - use_tls (Boolean) Whether to use TLS for secure logging
  EOF
  type = list(object({
    name               = string
    format             = optional(string)
    format_version     = optional(number)
    placement          = optional(string)
    port               = optional(number)
    response_condition = optional(string)
    use_tls            = optional(bool)
  }))
  default = []
}

# Logging Loggly
variable "fastly_logging_loggly_token" {
  default     = ""
  description = "(String, Sensitive) The token to use for authentication (https://www.loggly.com/docs/customer-token-authentication-token/)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_loggly" {
  description = <<EOF
  A list of logging Loggly settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Loggly logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
  }))
  default = []
}

# Logging Log Shuttle
variable "fastly_logging_logshuttle_token" {
  default     = ""
  description = "(String, Sensitive) The data authentication token associated with this endpoint (https://www.fastly.com/documentation/log-shuttle/)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_logshuttle" {
  description = <<EOF
  A list of logging Log Shuttle settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Log Shuttle logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - url (String) Your Log Shuttle endpoint URL
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
    url                = string
  }))
  default = []
}

# Logging New Relic
variable "fastly_logging_newrelic_token" {
  default     = ""
  description = "(String, Sensitive) The Insert API key from the Account page of your New Relic account (https://docs.newrelic.com/docs/logs/logging-api/logging-api-keys/insert-api-key/)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_newrelic" {
  description = <<EOF
  A list of logging New Relic settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache style log formatting. Your log must produce valid JSON that New Relic Logs can ingest.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the New Relic logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - region (String) The region that log data will be sent to. Default: US
  - response_condition (String) The name of the condition to apply.
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    region             = optional(string)
    response_condition = optional(string)
  }))
  default = []
}

# Logging New Relic OTLP
variable "fastly_logging_newrelicotlp_token" {
  default     = ""
  description = "(String, Sensitive) The Insert API key from the Account page of your New Relic account (https://docs.newrelic.com/docs/logs/logging-api/logging-api-keys/insert-api-key/)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_newrelicotlp" {
  description = <<EOF
  A list of logging New Relic OTLP settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache style log formatting. Your log must produce valid JSON that New Relic OTLP can ingest.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the New Relic OTLP logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - region (String) The region that log data will be sent to. Default: US
  - response_condition (String) The name of the condition to apply.
  - url (String) The optional New Relic Trace Observer URL to stream logs to for Infinite Tracing.
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    region             = optional(string)
    response_condition = optional(string)
    url                = optional(string)
  }))
  default = []
}

# Logging OpenStack
variable "fastly_logging_openstack_access_key" {
  default     = ""
  description = "(String, Sensitive) Your OpenStack account access key."
  sensitive   = true
  type        = string
}

variable "fastly_logging_openstack" {
  description = <<EOF
  A list of logging OpenStack settings to be added to the Fastly service. Each object in the list has the following attributes:
  - bucket_name (String) The name of your OpenStack container
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the OpenStack logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - path (String) Path to store the files. Must end with a trailing slash. If this field is left empty, the files will be saved in the bucket's root path
  - period (Number) How frequently the logs should be transferred, in seconds. Default 3600
  - placement (String) Where in the generated VCL the logging call should be placed. Can be none or none.
  - public_key (String) A PGP public key that Fastly will use to encrypt your log files before writing them to disk
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  - timestamp_format (String) The strftime specified timestamp formatting (default %Y-%m-%dT%H:%M:%S.000)
  - url (String) Your OpenStack auth url
  - user (String) The username for your OpenStack account
  EOF
  type = list(object({
    bucket_name        = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = optional(string)
    period             = optional(number)
    placement          = optional(string)
    public_key         = optional(string)
    response_condition = optional(string)
    timestamp_format   = optional(string)
    url                = string
    user               = string
  }))
  default = []
}

# Logging Papertrail
variable "fastly_logging_papertrail" {
  description = <<EOF
  A list of logging Papertrail settings to be added to the Fastly service. Each object in the list has the following attributes:
  - address (String) The address of the Papertrail endpoint
  - format (String) A Fastly log format string
  - format_version (Number) The version of the custom logging format used for the configured endpoint. The logging call gets placed by default in vcl_log if format_version is set to 2 and in vcl_deliver if format_version is set to 1
  - name (String) A unique name to identify this Papertrail endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed. If not set, endpoints with format_version of 2 are placed in vcl_log and those with format_version of 1 are placed in vcl_deliver
  - port (Number) The port associated with the address where the Papertrail endpoint can be accessed
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute
  EOF
  type = list(object({
    address            = string
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    port               = number
    response_condition = optional(string)
  }))
  default = []
}

# Logging S3
variable "fastly_logging_s3_access_key" {
  default     = ""
  description = "(String, Sensitive) AWS Access Key of an account with the required permissions to post logs. It is strongly recommended you create a separate IAM user with permissions to only operate on this Bucket. This key will be not be encrypted. Not required if iam_role is provided. You can provide this key via an environment variable, FASTLY_S3_ACCESS_KEY"
  sensitive   = true
  type        = string
}

variable "fastly_logging_s3_secret_key" {
  default     = ""
  description = "(String, Sensitive) AWS Secret Key of an account with the required permissions to post logs. It is strongly recommended you create a separate IAM user with permissions to only operate on this Bucket. This secret will be not be encrypted. Not required if iam_role is provided. You can provide this secret via an environment variable, FASTLY_S3_SECRET_KEY"
  sensitive   = true
  type        = string
}

variable "fastly_logging_s3" {
  description = <<EOF
  A list of logging S3 settings to be added to the Fastly service. Each object in the list has the following attributes:
  - acl (String) The AWS Canned ACL to use for objects uploaded to the S3 bucket. Options are: private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, bucket-owner-full-control
  - bucket_name (String) The name of the bucket in which to store the logs
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - domain (String) If you created the S3 bucket outside of us-east-1, then specify the corresponding bucket endpoint. Example: s3-us-west-2.amazonaws.com
  - file_max_bytes (Number) Maximum size of an uploaded log file, if non-zero.
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (Default: 2).
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the S3 logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - path (String) Path to store the files. Must end with a trailing slash. If this field is left empty, the files will be saved in the bucket's root path
  - period (Number) How frequently the logs should be transferred, in seconds. Default 3600
  - placement (String) Where in the generated VCL the logging call should be placed.
  - public_key (String) A PGP public key that Fastly will use to encrypt your log files before writing them to disk
  - redundancy (String) The S3 storage class (redundancy level). Should be one of: standard, intelligent_tiering, standard_ia, onezone_ia, glacier, glacier_ir, deep_archive, or reduced_redundancy
  - response_condition (String) Name of blockAttributes condition to apply this logging.
  - s3_iam_role (String) The Amazon Resource Name (ARN) for the IAM role granting Fastly access to S3. Not required if access_key and secret_key are provided. You can provide this value via an environment variable, FASTLY_S3_IAM_ROLE
  - server_side_encryption (String) Specify what type of server side encryption should be used. Can be either AES256 or aws:kms
  - server_side_encryption_kms_key_id (String) Optional server-side KMS Key Id. Must be set if server_side_encryption is set to aws:kms
  - timestamp_format (String) The strftime specified timestamp formatting (default %Y-%m-%dT%H:%M:%S.000)
  EOF
  type = list(object({
    acl                               = optional(string)
    bucket_name                       = string
    compression_codec                 = optional(string)
    domain                            = optional(string)
    file_max_bytes                    = optional(number)
    format                            = optional(string)
    format_version                    = optional(number)
    gzip_level                        = optional(number)
    message_type                      = optional(string)
    name                              = string
    path                              = optional(string)
    period                            = optional(number)
    placement                         = optional(string)
    public_key                        = optional(string)
    redundancy                        = optional(string)
    response_condition                = optional(string)
    s3_iam_role                       = optional(string)
    server_side_encryption            = optional(string)
    server_side_encryption_kms_key_id = optional(string)
    timestamp_format                  = optional(string)
  }))
  default = []
}

# Logging Scalyr
variable "fastly_logging_scalyr_token" {
  default     = ""
  description = "(String, Sensitive) The token to use for authentication (https://www.scalyr.com/keys)"
  sensitive   = true
  type        = string
}

variable "fastly_logging_scalyr" {
  description = <<EOF
  A list of logging Scalyr settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache style log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - name (String) The unique name of the Scalyr logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - project_id (String) The name of the logfile field sent to Scalyr
  - region (String) The region that log data will be sent to. One of US or EU. Defaults to US if undefined
  - response_condition (String) The name of an existing condition in the configured endpoint, or leave blank to always execute.
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    project_id         = optional(string)
    region             = optional(string)
    response_condition = optional(string)
  }))
  default = []
}

# Logging SFTP
variable "fastly_logging_sftp_password" {
  default     = ""
  description = "(String, Sensitive) The password for the server. If both password and secret_key are passed, secret_key will be preferred"
  sensitive   = true
  type        = string
}

variable "fastly_logging_sftp_secret_key" {
  default     = ""
  description = "(String, Sensitive) The SSH private key for the server. If both password and secret_key are passed, secret_key will be preferred"
  sensitive   = true
  type        = string
}

variable "fastly_logging_sftp" {
  description = <<EOF
  A list of logging SFTP settings to be added to the Fastly service. Each object in the list has the following attributes:
  - address (String) The SFTP address to stream logs to
  - compression_codec (String) The codec used for compression of your logs. Valid values are zstd, snappy, and gzip. If the specified codec is "gzip", gzip_level will default to 3. To specify a different level, leave compression_codec blank and explicitly set the level using gzip_level. Specifying both compression_codec and gzip_level in the same API request will result in an error.
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2).
  - gzip_level (Number) Level of Gzip compression from 0-9. 0 means no compression. 1 is the fastest and the least compressed version, 9 is the slowest and the most compressed version. Default 0
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) The unique name of the SFTP logging endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - path (String) The path to upload log files to. If the path ends in / then it is treated as a directory
  - period (Number) How frequently log files are finalized so they can be available for reading (in seconds, default 3600)
  - placement (String) Where in the generated VCL the logging call should be placed.
  - port (Number) The port the SFTP service listens on. (Default: 22)
  - public_key (String) A PGP public key that Fastly will use to encrypt your log files before writing them to disk
  - response_condition (String) The name of the condition to apply.
  - ssh_known_hosts (String) A list of host keys for all hosts we can connect to over SFTP
  - timestamp_format (String) The strftime specified timestamp formatting (default %Y-%m-%dT%H:%M:%S.000)
  - user (String) The username for the server
  EOF
  type = list(object({
    address            = string
    compression_codec  = optional(string)
    format             = optional(string)
    format_version     = optional(number)
    gzip_level         = optional(number)
    message_type       = optional(string)
    name               = string
    path               = string
    period             = optional(number)
    placement          = optional(string)
    port               = optional(number)
    public_key         = optional(string)
    response_condition = optional(string)
    ssh_known_hosts    = string
    timestamp_format   = optional(string)
    user               = string
  }))
  default = []
}

# Logging Splunk
variable "fastly_logging_splunk_token" {
  default     = ""
  description = "(String, Sensitive) The Splunk token to be used for authentication (https://docs.splunk.com/Documentation/Splunk/latest/Data/UsetheHTTPEventCollector)."
  sensitive   = true
  type        = string
}

variable "fastly_logging_splunk_tls_client_key" {
  default     = ""
  description = "(String, Sensitive) The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, FASTLY_SPLUNK_CLIENT_KEY."
  sensitive   = true
  type        = string
}

variable "fastly_logging_splunk" {
  description = <<EOF
  A list of logging Splunk settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting (default: %h %l %u %t "%r" %>s %b)
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (default: 2)
  - name (String) A unique name to identify the Splunk endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed
  - response_condition (String) The name of the condition to apply
  - tls_ca_cert (String) A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, FASTLY_SPLUNK_CA_CERT
  - tls_client_cert (String) The client certificate used to make authenticated requests. Must be in PEM format.
  - tls_hostname (String) The hostname used to verify the server's certificate. It can either be the Common Name or a Subject Alternative Name (SAN)
  - url (String) The Splunk URL to stream logs to
  - use_tls (Boolean) Whether to use TLS for secure logging. Default: false
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
    tls_ca_cert        = optional(string)
    tls_client_cert    = optional(string)
    tls_hostname       = optional(string)
    url                = string
    use_tls            = optional(bool)
  }))
  default = []
}

# Logging Sumologic
variable "fastly_logging_sumologic" {
  description = <<EOF
  A list of logging SumoLogic settings to be added to the Fastly service. Each object in the list has the following attributes:
  - format (String) Apache-style string or VCL variables to use for log formatting
  - format_version (Number) The version of the custom logging format used for the configured endpoint. Can be either 1 or 2. (Default: 2)
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic
  - name (String) A unique name to identify this Sumologic endpoint. It is important to note that changing this attribute will delete and recreate the resource
  - placement (String) Where in the generated VCL the logging call should be placed.
  - response_condition (String) Name of blockAttributes condition to apply this logging.
  - url (String) The URL to Sumologic collector endpoint
  EOF
  type = list(object({
    format             = optional(string)
    format_version     = optional(number)
    message_type       = optional(string)
    name               = string
    placement          = optional(string)
    response_condition = optional(string)
    url                = string
  }))
  default = []
}

# Logging syslog
variable "fastly_logging_syslog_tls_client_key" {
  default     = ""
  description = "logging_syslog tls_client_key (String, Sensitive) The client private key used to make authenticated requests. Must be in PEM format. You can provide this key via an environment variable, FASTLY_SYSLOG_CLIENT_KEY."
  sensitive   = true
  type        = string
}

variable "fastly_logging_syslog" {
  description = <<EOF
  A list of logging syslog settings to be added to the Fastly service. Each object in the list has the following attributes:
  - address (String) A hostname or IPv4 address of the Syslog endpoint.
  - format (String) Apache-style string or VCL variables to use for log formatting.
  - format_version (String) The version of the custom logging format. Can be either 1 or 2. Default: 2
  - message_type (String) How the message should be formatted. Can be either classic, loggly, logplex or blank. Default is classic.
  - name (String) A unique name to identify this Syslog endpoint. It is important to note that changing this attribute will delete and recreate the resource.
  - placement (String) Where in the generated VCL the logging call should be placed.
  - port (Number) The port associated with the address where the Syslog endpoint can be accessed. Default 514
  - response_condition (String) Name of blockAttributes condition to apply this logging.
  - tls_ca_cert (String) A secure certificate to authenticate the server with. Must be in PEM format. You can provide this certificate via an environment variable, FASTLY_SYSLOG_CA_CERT.
  - tls_client_cert (String) The client certificate used to make authenticated requests. Must be in PEM format. You can provide this certificate via an environment variable, FASTLY_SYSLOG_CLIENT_CERT.
  - tls_hostname (String) Used during the TLS handshake to validate the certificate.
  - token (String) Whether to prepend each message with a specific token.
  - use_tls (Boolean) Whether to use TLS for secure logging. Default false
  EOF
  type = list(object({
    address            = string
    format             = optional(string)
    format_version     = optional(number)
    message_type       = optional(string)
    name               = string
    placement          = optional(string)
    port               = optional(number)
    response_condition = optional(string)
    tls_ca_cert        = optional(string)
    tls_client_cert    = optional(string)
    tls_hostname       = optional(string)
    token              = optional(string)
    use_tls            = optional(bool)
  }))
  default = []
}
