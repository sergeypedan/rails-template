# frozen_string_literal: true

Rails.application.configure do

  # ActiveRecord

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false



  # ActiveStorage

  # Store uploaded files on the local file system (see config/storage.yml for options)
  # config.active_storage.service = :local
  config.active_storage.service = :amazon

  # https://api.rubyonrails.org/classes/ActiveStorage/Variant.html
  # config.active_storage.variant_processor = :vips  # needs special set-up with buildpacks for Heroku… meh




  # Action Cable

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]



  # Assets

  # Disable serving static files from the `/public` folder by default since Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  # config.assets.js_compressor = :uglifier
  config.assets.js_compressor = Uglifier.new(harmony: true)

  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "https://#{Rails.application.credentials.domain}"

  # Asset digests allow you to set far-future HTTP expiration dates on all assets, yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Verifies that versions and hashed value of the package contents in the project's package.json
  config.webpacker.check_yarn_integrity = false



  # Background jobs

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :sidekiq # :resque
  # config.active_job.queue_name_prefix = "#{Rails.application.class.name.sub("::Application", "").tableize}_ru_production"



  # Caching etc

  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application. Add `rack-cache` to your Gemfile before enabling this. For large-scale production use, consider using a caching reverse proxy like NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Full error reports are disabled
  config.consider_all_requests_local = false

  # Eager load code on boot. This eager loads most of Rails and your application in memory, allowing both threaded web servers and those relying on copy on write to perform better. Rake tasks automatically ignore this option for performance.
  config.eager_load = true



  # Credentials

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"] or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  config.read_encrypted_secrets = true

  config.require_master_key = true



  # Headers

  config.action_dispatch.default_headers = {
    "Content-Security-Policy"           => HeaderPolicy::ContentSecurity.new.call,
    "Feature-Policy"                    => HeaderPolicy::Feature.new.call,
    "Referrer-Policy"                   => "strict-origin-when-cross-origin",
    "Strict-Transport-Security"         => "max-age=31536000; includeSubDomains",
    "X-Content-Type-Options"            => "nosniff",
    "X-Download-Options"                => "noopen",
    "X-Frame-Options"                   => "SAMEORIGIN",
    "X-Permitted-Cross-Domain-Policies" => "none",
    "X-XSS-Protection"                  => "1; mode=block"
  }

  config.session_store :cookie_store, httponly: true, key: '__Secure-session', same_site: :lax, secure: true

  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX
  config.action_dispatch.x_sendfile_header = nil # for Heroku
  # Specifies the header that your server uses for sending files.



  # I18n

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to the I18n.default_locale when a translation cannot be found).
  # config.i18n.fallbacks = true
  # https://github.com/svenfuchs/i18n/releases/tag/v1.1.0
  config.i18n.fallbacks = [I18n.default_locale]



  # Logging

  # Use the lowest log level to ensure availability of diagnostic information when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :request_id ]
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end



  # Mailer

  config.action_mailer.asset_host = "https://#{Rails.application.credentials.domain}"

  config.action_mailer.default_url_options = { host: Rails.application.credentials.domain }

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.perform_caching = false

  config.action_mailer.smtp_settings = {
    address:              Rails.application.credentials.dig(:mailgun, :smtp, :host),
    authentication:      'plain',
    domain:               Rails.application.credentials.domain,
    enable_starttls_auto: false,
    password:             Rails.application.credentials.dig(:mailgun, :smtp, :password),
    port:                 587,
    user_name:            Rails.application.credentials.dig(:mailgun, :smtp, :username),
  }

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = false




  # Multiple databases

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session

end
