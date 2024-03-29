require "active_support/core_ext/integer/time"

Rails.application.configure do


  # ActiveRecord

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true



  # ActiveStorage

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log



	# Cable

	# Uncomment if you wish to allow Action Cable access from any origin.
	# config.action_cable.disable_request_forgery_protection = true



  # Assets

  # config.action_controller.asset_host = "http://localhost:3000"

  # Debug mode disables concatenation and preprocessing of assets. This option may cause significant delays in view rendering with a large number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime. Checks for improperly declared sprockets dependencies. Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Verifies that versions and hashed value of the package contents in the project’s package.json
  # config.webpacker.check_yarn_integrity = true



  # Caching etc

  # Use an evented file watcher to asynchronously detect changes in source code, routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # In the development environment your application’s code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don’t have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    # determines whether to log fragment cache reads and writes in verbose format
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end



  # Headers

  config.action_dispatch.default_headers = {
    # "X-Frame-Options" => "SAMEORIGIN",
    "Referrer-Policy"                   => "strict-origin-when-cross-origin",
    "X-Content-Type-Options"            => "nosniff",
    "X-Download-Options"                => "noopen",
    "X-Frame-Options"                   => "ALLOW-FROM https://youtube.com/",
    "X-Permitted-Cross-Domain-Policies" => "none",
    "X-XSS-Protection"                  => "1; mode=block"
  }




  # Mailer

  # Don’t care if the mailer can’t send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

  config.action_mailer.asset_host = "http://localhost:3000"

  # config.action_mailer.delivery_method = :smtp
  config.action_mailer.delivery_method = :letter_opener

  config.action_mailer.preview_path = Rails.root.join("spec", "mailers", "previews").to_s

  # config.active_job.queue_adapter = :async
  # config.active_job.queue_adapter = :sidekiq




  # I18n

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  # Raises error for missing translations
  config.i18n.raise_on_missing_translations = true



	# Deprecations

	# Raise exceptions for disallowed deprecations.
	config.active_support.disallowed_deprecation = :raise

	# Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

end
