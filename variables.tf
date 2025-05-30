# Fastly API
variable "fastly_api_key" {
  description = "The Fastly API key"
  sensitive   = true
  type        = string
}

# Service
variable "fastly_activate" {
  description = "(Boolean) Conditionally prevents new service versions from being activated. The apply step will create a new draft version but will not activate it if this is set to false. Default true"
  type        = bool
  default     = true
}

variable "fastly_default_host" {
  description = "(String) The default hostname"
  type        = string
  default     = ""
}
variable "fastly_default_ttl" {
  description = "(Number) The default Time-to-live (TTL) for requests"
  type        = number
  default     = 3600
}

variable "fastly_force_destroy" {
  description = "(Boolean) Services that are active cannot be destroyed. In order to destroy the Service, set force_destroy to true. Default false"
  type        = bool
  default     = false
}

variable "fastly_http3" {
  description = "(Boolean) Enables support for the HTTP/3 (QUIC) protocol. Default true"
  type        = bool
  default     = true
}

variable "fastly_stage" {
  description = "(Boolean) Conditionally enables new service versions to be staged. If set to true, all changes made by an apply step will be staged, even if apply did not create a new draft version. Default false"
  type        = bool
  default     = false
}

variable "fastly_service_comment" {
  description = "(String) Description field for the service. Default Managed by Terraform"
  type        = string
  default     = "Managed by Terraform"
}

variable "fastly_stale_if_error" {
  description = "(Boolean) Enables serving a stale object if there is an error. Default true"
  type        = bool
  default     = true
}
variable "fastly_stale_if_error_ttl" {
  description = "(Number) The default time-to-live (TTL) for serving the stale object for the version"
  type        = number
  default     = 43200
}

# ACLs
variable "fastly_acls" {
  description = <<EOF
  A list of ACLs to be added to the Fastly service. Each object in the list has the following attributes:
  - entries (List) A list of ACL entries. Each object in the list has the following attributes:
    - comment (String) A personal freeform descriptive note
    - ip (String) An IP address that is the focus for the ACL
    - negated (Boolean) A boolean that will negate the match if true
    - subnet (String) An optional subnet mask applied to the IP address
  - force_destroy (Boolean) Allow the ACL to be deleted, even if it contains entries. Defaults to false.
  - manage_entries (Boolean) Whether to reapply changes if the state of the entries drifts, i.e. if entries are managed externally.
  - name (String) A unique name to identify this ACL. It is important to note that changing this attribute will delete and recreate the ACL, and discard the current items in the ACL.
  EOF
  type = list(object({
    entries = list(object({
      comment = optional(string)
      ip      = string
      negated = optional(bool)
      subnet  = optional(string)
    }))
    force_destroy  = optional(bool, false)
    manage_entries = bool
    name           = string
  }))
  default = []
}

# Backends
variable "fastly_backends" {
  description = <<EOF
  A list of backends to be added to the Fastly service. Each object in the list has the following attributes:
  - address (String) An IPv4, hostname, or IPv6 address for the Backend
  - name (String) Name for this Backend. Must be unique to this Service. It is important to note that changing this attribute will delete and recreate the resource.
  - auto_loadbalance (Boolean) Denotes if this Backend should be included in the pool of backends that requests are load balanced against. Default false
  - between_bytes_timeout (Number) How long to wait between bytes in milliseconds. Default 10000
  - connect_timeout (Number) How long to wait for a timeout in milliseconds. Default 1000
  - error_threshold (Number) How many errors should be seen before this backend is considered unhealthy. Default 0
  - first_byte_timeout (Number) How long to wait for the first byte in milliseconds. Default 15000
  - healthcheck (String) The name of the healthcheck to use with this backend
  - keepalive_time (Number) How long to keep a connection to the backend open in seconds. Default 60
  - max_conn (Number) The maximum number of connections to the backend. Default 200
  - max_tls_version (String) The maximum version of TLS the backend supports
  - min_tls_version (String) The minimum version of TLS the backend supports
  - override_host (String) The hostname to override the Host header
  - port (Number) The port number of the address. Default 80
  - request_condition (String) Name of a condition, which if met, will select this backend during a request.
  - share_key (String) Value that when shared across backends will enable those backends to share the same health check.
  - shield (String) The POP of the shield designated to reduce inbound load. Valid values for shield are included in the GET /datacenters API response
  - ssl_ca_cert (String) CA certificate attached to origin.
  - ssl_cert_hostname (String) Configure certificate validation. Does not affect SNI at all
  - ssl_check_cert (Boolean) Check the backend certificate. Default true
  - ssl_ciphers (String) Cipher list consisting of one or more cipher strings separated by colons. Commas or spaces are also acceptable separators but colons are normally used.
  - ssl_client_cert (String) Client certificate attached to origin.
  - ssl_client_key (String, Sensitive) Client key attached to origin.
  - ssl_sni_hostname (String) SNI host name to use during SSL handshake. This is required when using SSL.
  - use_ssl (Boolean) Use SSL for this backend. Default false
  - weight (Number) Weight used to load balance this backend against others. Default 100
  EOF
  type = list(object({
    address               = string
    auto_loadbalance      = optional(bool, false)
    between_bytes_timeout = optional(number, 10000)
    connect_timeout       = optional(number, 1000)
    error_threshold       = optional(number, 0)
    first_byte_timeout    = optional(number, 15000)
    healthcheck           = optional(string)
    keepalive_time        = optional(number, 60)
    max_conn              = optional(number, 200)
    max_tls_version       = optional(string)
    min_tls_version       = optional(string)
    name                  = string
    override_host         = optional(string)
    port                  = optional(number, 80)
    request_condition     = optional(string)
    share_key             = optional(string)
    shield                = optional(string)
    ssl_ca_cert           = optional(string)
    ssl_cert_hostname     = optional(string)
    ssl_check_cert        = optional(bool, true)
    ssl_ciphers           = optional(string)
    ssl_client_cert       = optional(string)
    ssl_client_key        = optional(string)
    ssl_sni_hostname      = optional(string)
    use_ssl               = optional(bool, false)
    weight                = optional(number, 100)
  }))
  default = []
}

# Cache Settings
variable "fastly_cache_setting" {
  description = <<EOF
  A list of cache settings to be added to the Fastly service. Each object in the list has the following attributes:
  - action (String) One of cache, pass, or restart, as defined on Fastly's documentation under "Caching action descriptions"
  - cache_condition (String) Name of already defined condition used to test whether this settings object should be used. This condition must be of type CACHE
  - name (String) Unique name for this Cache Setting. It is important to note that changing this attribute will delete and recreate the resource
  - stale_ttl (Number) Max "Time To Live" for stale (unreachable) objects
  - ttl (Number) The Time-To-Live (TTL) for the object
  EOF
  type = list(object({
    action          = string
    cache_condition = string
    name            = string
    stale_ttl       = optional(number)
    ttl             = optional(number)
  }))
  default = []

  validation {
    # Validate action values
    condition     = alltrue([for i in var.fastly_cache_setting : contains(["cache", "pass", "restart"], i.action)])
    error_message = "action must be one of: cache, pass, restart"
  }
}


# Conditions
variable "fastly_conditions" {
  description = <<EOF
  A list of conditions to be added to the Fastly service. Each object in the list has the following attributes:
  - name (String) The unique name for the condition. It is important to note that changing this attribute will delete and recreate the resource.
  - priority (Number) A number used to determine the order in which multiple conditions execute. Lower numbers execute first. Default 10
  - statement (String) The statement used to determine if the condition is met.
  - type (String) Type of condition, either REQUEST (req), RESPONSE (req, resp), or CACHE (req, beresp).
  EOF
  type = list(object({
    name      = string
    priority  = optional(number, 10)
    statement = string
    type      = string
  }))
  default = []
}

# Dictionaries
variable "fastly_dictionaries" {
  description = <<EOF
  A list of dictionaries to be added to the Fastly service. Each object in the list has the following attributes:
  - force_destroy (Boolean) Allow the dictionary to be deleted, even if it contains entries. Defaults to false.
  - items (Map of String) A map representing an entry in the dictionary, (key/value)
  - manage_items (Boolean) Whether to reapply changes if the state of the items drifts, i.e. if items are managed externally.
  - name (String) A unique name to identify this dictionary. It is important to note that changing this attribute will delete and recreate the dictionary, and discard the current items in the dictionary.
  EOF
  type = list(object({
    force_destroy = optional(bool, false)
    items         = map(string)
    manage_items  = bool
    name          = string
  }))
  default = []
}

# Directors
variable "fastly_directors" {
  description = <<EOF
  A list of directors to be added to the Fastly service. Each object in the list has the following attributes:
  - backends (Set of String) Names of defined backends to map the Director to. Example: [ "origin1", "origin2" ]
  - comment (String) A comment to describe the Director.
  - name (String) Unique name for this Director. It is important to note that changing this attribute will delete and recreate the resource
  - quorum (Number) Percentage of capacity that needs to be up for the director itself to be considered up. Default 75
  - retries (Number) Number of retries to perform before failing over to the next backend. Default 5
  - shield (String) Selected POP to serve as a "shield" for backends. Valid values for shield are included in the GET /datacenters API response
  - type (Number) Type of load balance group to use. Integer, 1 to 4. Values: 1 for round-robin, 2 for random, 3 for hash, 4 for client. Default 1
  EOF
  type = list(object({
    backends = set(string)
    comment  = optional(string)
    name     = string
    quorum   = optional(number, 75)
    retries  = optional(number, 5)
    shield   = optional(string)
    type     = optional(number, 1)
  }))
  default = []

  validation {
    # Validate type values
    condition     = alltrue([for i in var.fastly_directors : (i.type != null ? contains([1, 2, 3, 4], i.type) : true)])
    error_message = "type, if provided, must be one of: 1, 2, 3, 4"
  }
}

# Domain Names
variable "fastly_domain_names" {
  description = "List of domains to be added to the Fastly service."
  type = list(object({
    name    = string
    comment = optional(string)
  }))
}

# Dynamic Snippets
variable "fastly_dynamic_snippets" {
  description = <<EOF
  A list of dynamic VCL snippets to be added to the Fastly service. Each object in the list has the following attributes:
  - content (String) The VCL code that specifies exactly what the snippet does.
  - priority (Number) Priority determines the ordering for multiple snippets. Lower numbers execute first. Defaults to 100
  - manage (Boolean) Whether to reapply changes if the state of the snippets drifts, i.e. if snippets are managed externally.
  - name (String) A name that is unique across "regular" and "dynamic" VCL Snippet configuration blocks. It is important to note that changing this attribute will delete and recreate the resource.
  - type (String) The location in generated VCL where the snippet should be placed (can be one of init, recv, hash, hit, miss, pass, fetch, error, deliver, log or none).
  EOF
  type = list(object({
    content  = optional(string)
    priority = optional(number, 100)
    manage   = optional(bool, false)
    name     = string
    type     = string
  }))
  default = []

  validation {
    # Validate type values
    condition     = alltrue([for i in var.fastly_dynamic_snippets : contains(["init", "recv", "hash", "hit", "miss", "pass", "fetch", "error", "deliver", "log", "none"], i.type)])
    error_message = "type must be one of: init, recv, hash, hit, miss, pass, fetch, error, deliver, log, none"
  }
}

# Gzip Settings
variable "fastly_gzip_settings" {
  description = <<EOF
  A list of gzip settings to be added to the Fastly service. Each object in the list has the following attributes:
  - cache_condition (String) Name of already defined condition controlling when this gzip configuration applies. This condition must be of type CACHE.
  - content_types (List of String) The content-type for each type of content you wish to have dynamically gzip'ed. Example: ["text/html", "text/css"]
  - extensions (List of String) File extensions for each file type to dynamically gzip. Example: ["css", "js"]
  - name (String) A name to refer to this gzip condition. It is important to note that changing this attribute will delete and recreate the resource.
  EOF
  type = list(object({
    cache_condition = optional(string)
    content_types   = optional(list(string))
    extensions      = optional(list(string))
    name            = string
  }))
  default = []
}

# Headers
variable "fastly_headers" {
  description = <<EOF
  A list of headers to be added to the Fastly service. Each object in the list has the following attributes:
  - action (String) The Header manipulation action to take; must be one of set, append, delete, regex, or regex_repeat
  - cache_condition (String) Name of already defined condition to apply. This condition must be of type CACHE
  - destination (String) The name of the header that is going to be affected by the Action
  - ignore_if_set (Boolean) Don't add the header if it is already. (Only applies to set action.). Default false
  - name (String) A name to refer to this header condition. It is important to note that changing this attribute will delete and recreate the resource.
  - priority (Number) Lower priorities execute first. Default: 100
  - regex (String) Regular expression to use (Only applies to regex and regex_repeat actions.)
  - request_condition (String) Name of already defined condition to apply. This condition must be of type REQUEST
  - response_condition (String) Name of already defined condition to apply. This condition must be of type RESPONSE
  - source (String) Variable to be used as a source for the header content (Does not apply to delete action.)
  - substitution (String) The substitution string to use (Only applies to regex and regex_repeat actions.)
  - type (String) The Request type on which to apply the selected Action; must be one of request, fetch, cache or response
  EOF
  type = list(object({
    action             = string
    cache_condition    = optional(string)
    destination        = string
    ignore_if_set      = optional(bool, false)
    name               = string
    priority           = optional(number, 100)
    regex              = optional(string)
    request_condition  = optional(string)
    response_condition = optional(string)
    source             = optional(string)
    substitution       = optional(string)
    type               = string
  }))
  default = []

  validation {
    # Validate action values
    condition     = alltrue([for i in var.fastly_headers : contains(["set", "append", "delete", "regex", "regex_repeat"], i.action)])
    error_message = "type must be one of: set, append, delete, regex, regex_repeat"
  }

  validation {
    # Validate type values
    condition     = alltrue([for i in var.fastly_headers : contains(["request", "fetch", "cache", "response"], i.type)])
    error_message = "type must be one of: request, fetch, cache, response"
  }
}

# Healthchecks
variable "fastly_healthchecks" {
  description = <<EOF
  A list of healthchecks to be added to the Fastly service. Each object in the list has the following attributes:
  - check_interval (Number) How often to run the Healthcheck in milliseconds. Default 5000
  - expected_response (Number) The status code expected from the host. Default 200
  - headers (Set of String) Custom headers to send with the Healthcheck. Each header should be in the format "Header: Value". To remove all headers, first specify an empty string. Example: ["Accept: application/json", "User-Agent: fastly-healthchecks"]
  - host (String) The Host header to send for this Healthcheck.
  - http_version (String) Whether to use version 1.0 or 1.1 HTTP. Default 1.1
  - initial (Number) When loading a config, the initial number of probes to be seen as OK. Default 3
  - method (String) Which HTTP method to use. Default HEAD
  - name (String) A unique name to identify this Healthcheck. It is important to note that changing this attribute will delete and recreate the resource
  - path (String) The path to check
  - threshold (Number) How many Healthchecks must succeed to be considered healthy. Default 3
  - timeout (Number) Timeout in milliseconds. Default 5000
  - window (Number) The number of most recent Healthcheck queries to keep for this Healthcheck. Default 5
  EOF
  type = list(object({
    check_interval    = optional(number, 5000)
    expected_response = optional(number, 200)
    headers           = optional(set(string))
    host              = string
    http_version      = optional(string, "1.1")
    initial           = optional(number, 3)
    method            = optional(string, "HEAD")
    name              = string
    path              = string
    threshold         = optional(number, 3)
    timeout           = optional(number, 5000)
    window            = optional(number, 5)
  }))
  default = []
}

# Image Optimizer Settings
variable "fastly_image_optimizers" {
  description = <<EOF
  A single-item list of settings for the image optimizer to be added to the Fastly service. Each object in the list has the following attributes:
  - allow-video (Boolean) Enables GIF to MP4 transformations on this service.
  - jpeg_quality (Number) The default quality to use with JPEG output. This can be overridden with the "quality" parameter on specific image optimizer requests.
  - jpeg_type (String) The default type of JPEG output to use. This can be overridden with "format=bjpeg" and "format=pjpeg" on specific image optimizer requests. Valid values are auto, baseline and progressive.
    - auto: Match the input JPEG type, or baseline if transforming from a non-JPEG input.
    - baseline: Output baseline JPEG images
    - progressive: Output progressive JPEG images
  - name (String) Used by the provider to identify modified settings. Changing this value will force the entire block to be deleted, then recreated.
  - resize_filter (String) The type of filter to use while resizing an image. Valid values are lanczos3, lanczos2, bicubic, bilinear and nearest.
    - lanczos3: A Lanczos filter with a kernel size of 3. Lanczos filters can detect edges and linear features within an image, providing the best possible reconstruction.
    - lanczos2: A Lanczos filter with a kernel size of 2.
    - bicubic: A filter using an average of a 4x4 environment of pixels, weighing the innermost pixels higher.
    - bilinear: A filter using an average of a 2x2 environment of pixels.
    - nearest: A filter using the value of nearby translated pixel values. Preserves hard edges.
  - upscale (Boolean) Whether or not we should allow output images to render at sizes larger than input.
  - webp (Boolean) Controls whether or not to default to WebP output when the client supports it. This is equivalent to adding "auto=webp" to all image optimizer requests.
  - webp_quality (Number) The default quality to use with WebP output. This can be overridden with the second option in the "quality" URL parameter on specific image optimizer requests.
  EOF
  type = list(object({
    allow_video   = optional(bool)
    jpeg_quality  = optional(number)
    jpeg_type     = optional(string)
    name          = string
    resize_filter = optional(string)
    upscale       = optional(bool)
    webp          = optional(bool)
    webp_quality  = optional(number)
  }))
  default = []

  validation {
    # Validate jpeg_type values
    condition     = alltrue([for i in var.fastly_image_optimizers : (i.jpeg_type != null ? contains(["auto", "baseline", "progressive"], i.jpeg_type) : true)])
    error_message = "jpeg_type, if provided, must be one of: auto, baseline, progressive"
  }

  validation {
    # Validate resize_filter values
    condition     = alltrue([for i in var.fastly_image_optimizers : (i.resize_filter != null ? contains(["lanczos3", "lanczos2", "bicubic", "bilinear", "nearest"], i.resize_filter) : true)])
    error_message = "resize_filter, if provided, must be one of: lanczos3, lanczos2, bicubic, bilinear, nearest"
  }
}

# Product Enablement Settings
variable "fastly_product_enablement" {
  description = <<EOF
  A single-item list of settings for product enablement to be added to the Fastly service. Each object in the list has the following attributes:
  - bot_management (Boolean) Enable Bot Management support.
  - brotli_compression (Boolean) Enable Brotli Compression support.
  - ddos_protection (Block List) A single block list of DDoS Protection product settings with the following attributes:
    - enabled (Boolean) Enable DDoS Protection support.
    - mode (String) Operation mode.
  - domain_inspector (Boolean) Enable Domain Inspector support.
  - image_optimizer (Boolean) Enable Image Optimizer support (all backends must have a shield attribute).
  - log_explorer_insights (Boolean) Enable Log Explorer & Insights.
  - name (String) Used by the provider to identify modified settings (changing this value will force the entire block to be deleted, then recreated).
  - ngwaf (Block List) A single block list of Next-Gen WAF product settings with the following attributes:
    - enabled (Boolean) Enable Next-Gen WAF support.
    - traffic_ramp (Number) The percentage of traffic to inspect.
    - workspace_id (String) The workspace to link.
  - origin_inspector (Boolean) Enable Origin Inspector support.
  - websockets (Boolean) Enable WebSockets support.
  EOF
  type = list(object({
    bot_management     = optional(bool)
    brotli_compression = optional(bool)
    ddos_protection = optional(object({
      enabled = bool
      mode    = string
    }))
    domain_inspector      = optional(bool)
    image_optimizer       = optional(bool)
    log_explorer_insights = optional(bool)
    name                  = optional(string)
    ngwaf = optional(object({
      enabled      = bool
      traffic_ramp = number
      workspace_id = string
    }))
    origin_inspector = optional(bool)
    websockets       = optional(bool)
  }))
  default = []
}

# Rate Limiters
variable "fastly_rate_limiters" {
  description = <<-EOF
  A list of rate limiters to be added to the Fastly service. Each object in the list has the following attributes:
  - action (String) The action to take when a rate limiter violation is detected (one of: log_only, response, response_object).
  - client_key (String) Comma-separated list of VCL variables used to generate a counter key to identify a client.
  - feature_revision (Number) Revision number of the rate limiting feature implementation.
  - http_methods (String) Comma-separated list of HTTP methods to apply rate limiting to.
  - logger_type (String) Name of the type of logging endpoint to be used when action is log_only (one of: azureblob, bigquery, cloudfiles, datadog, digitalocean, elasticsearch, ftp, gcs, googleanalytics, heroku, honeycomb, http, https, kafka, kinesis, logentries, loggly, logshuttle, newrelic, openstack, papertrail, pubsub, s3, scalyr, sftp, splunk, stackdriver, sumologic, syslog).
  - name_suffix (String) A unique human readable name suffix for the rate limiting rule.
  - penalty_box_duration (Number) Length of time in minutes that the rate limiter is in effect after the initial violation is detected.
  - response (Block List) A single block list of custom response settings to be sent when the rate limit is exceeded. Required if action is response. Consists of the following attributes:
    - content (String) HTTP response body data.
    - content_type (String) HTTP Content-Type (e.g. application/json).
    - status (Number) HTTP response status code (e.g. 429).
  - response_object_name (String) Name of existing response object. Required if action is response_object.
  - rps_limit (Number) Upper limit of requests per second allowed by the rate limiter.
  - uri_dictionary_name (String) The name of an Edge Dictionary containing URIs as keys. If not defined or null, all origin URIs will be rate limited.
  - window_size (Number) Number of seconds during which the RPS limit must be exceeded in order to trigger a violation (one of: 1, 10, 60).
  EOF

  type = list(object({
    action               = string
    client_key           = string
    feature_revision     = optional(number)
    http_methods         = string
    logger_type          = optional(string)
    name_suffix          = string
    penalty_box_duration = number
    response = optional(object({
      content      = string
      content_type = string
      status       = number
    }))
    response_object_name = optional(string)
    rps_limit            = number
    uri_dictionary_name  = optional(string)
    window_size          = number
  }))
  default = []

  validation {
    # Validate action values
    condition     = alltrue([for i in var.fastly_rate_limiters : contains(["log_only", "response", "response_object"], i.action)])
    error_message = "action must be one of: log_only, response, response_objec."
  }

  validation {
    # Validate logger_type values
    condition = alltrue(
      [for i in var.fastly_rate_limiters : (i.action == "log_only" ? contains(["azureblob", "bigquery", "cloudfiles", "datadog", "digitalocean", "elasticsearch", "ftp", "gcs", "googleanalytics", "heroku", "honeycomb", "http", "https", "kafka", "kinesis", "logentries", "loggly", "logshuttle", "newrelic", "openstack", "papertrail", "pubsub", "s3", "scalyr", "sftp", "splunk", "stackdriver", "sumologic", "syslog"], i.logger_type) : true)],
    )
    error_message = "logger_type, if action is log_only, must be one of: azureblob, bigquery, cloudfiles, datadog, digitalocean, elasticsearch, ftp, gcs, googleanalytics, heroku, honeycomb, http, https, kafka, kinesis, logentries, loggly, logshuttle, newrelic, openstack, papertrail, pubsub, s3, scalyr, sftp, splunk, stackdriver, sumologic, syslog"
  }

  validation {
    # Validate response settings exist for a response action
    condition = alltrue([
      for i in var.fastly_rate_limiters : (i.action == "response" ? i.response != null : true)
    ])
    error_message = "response settings are required for a response action"
  }

  validation {
    # Validate response_object_name exists for a response action
    condition = alltrue([
      for i in var.fastly_rate_limiters : (i.action == "response_object" ? i.response_object_name != null : true)
    ])
    error_message = "response_object_name is required for a response_object action"
  }

  validation {
    # Validate window_size values
    condition     = alltrue([for i in var.fastly_rate_limiters : contains([1, 10, 60], i.window_size)])
    error_message = "window_size must be one of: 1, 10, 60"
  }
}

# Request Settings
variable "fastly_request_settings" {
  description = <<EOF
  A list of request settings to be added to the Fastly service. Each object in the list has the following attributes:
  - action (String) Allows you to terminate request handling and immediately perform an action.
  - bypass_busy_wait (Boolean) Disable collapsed forwarding, so you don't wait for other objects to origin
  - default_host (String) Sets the host header
  - force_miss (Boolean) Force a cache miss for the request
  - force_ssl (Boolean) Forces the request to use SSL (Redirects a non-SSL request to SSL)
  - hash_keys (String) Comma separated list of varnish request object fields that should be in the hash key
  - max_stale_age (Number) How old an object is allowed to be to serve stale-if-error or stale-while-revalidate, in seconds
  - name (String) Unique name to refer to this Request Setting. It is important to note that changing this attribute will delete and recreate the resource.
  - request_condition (String) Name of already defined condition to determine if this request setting should be applied
  - timer_support (Boolean) Injects the X-Timer info into the request for viewing origin fetch durations
  - xff (String) X-Forwarded-For, should be clear, leave, append, append_all, or overwrite
  EOF
  type = list(object({
    action            = optional(string)
    bypass_busy_wait  = optional(bool)
    default_host      = optional(string)
    force_miss        = optional(bool)
    force_ssl         = optional(bool)
    hash_keys         = optional(string)
    max_stale_age     = optional(number)
    name              = string
    request_condition = optional(string)
    timer_support     = optional(bool)
    xff               = optional(string)
  }))
  default = []
}

# Response Objects
variable "fastly_response_objects" {
  description = <<EOF
  A list of response objects to be added to the Fastly service. Each object in the list has the following attributes:
  - cache_condition (String) Name of already defined condition to check after we have retrieved an object. If the condition passes then deliver this Request Object instead. This condition must be of type CACHE. For detailed information about Conditionals, see Fastly's Documentation on Conditionals
  - content (String) The content to deliver for the response object
  - content_type (String) The MIME type of the content
  - name (String) A unique name to identify this Response Object. It is important to note that changing this attribute will delete and recreate the resource.
  - request_condition (String) Name of already defined condition to be checked during the request phase. If the condition passes then this object will be delivered. This condition must be of type REQUEST
  - response (String) The HTTP Response. Default OK
  - status (Number) The HTTP Status Code. Default 200
  EOF
  type = list(object({
    cache_condition   = optional(string)
    content           = optional(string)
    content_type      = optional(string)
    name              = string
    request_condition = optional(string)
    response          = optional(string, "OK")
    status            = optional(number, 200)
  }))
  default = []
}

# Snippets
variable "fastly_snippets" {
  description = <<EOF
  A list of VCL snippets to be added to the Fastly service. Each object in the list has the following attributes:
  - content (String) The VCL code that specifies exactly what the snippet does.
  - name (String) A name that is unique across "regular" and "dynamic" VCL Snippet configuration blocks. It is important to note that changing this attribute will delete and recreate the resource.
  - priority (Number) Priority determines the ordering for multiple snippets. Lower numbers execute first. Defaults to 100
  - type (String) The location in generated VCL where the snippet should be placed (can be one of init, recv, hash, hit, miss, pass, fetch, error, deliver, log or none).
  EOF
  type = list(object({
    content  = string
    name     = string
    priority = optional(number, 100)
    type     = string
  }))
  default = []

  validation {
    # Validate type values
    condition     = alltrue([for i in var.fastly_snippets : contains(["init", "recv", "hash", "hit", "miss", "pass", "fetch", "error", "deliver", "log", "none"], i.type)])
    error_message = "type must be one of: init, recv, hash, hit, miss, pass, fetch, error, deliver, log, none"
  }
}
