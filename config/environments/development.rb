  config.action_dispatch.default_headers = {
    # 'X-Frame-Options' => 'SAMEORIGIN',
    'X-Frame-Options' => 'ALLOW-FROM https://youtube.com/',
    'X-XSS-Protection' => '1; mode=block',
    'X-Content-Type-Options' => 'nosniff',
    'X-Download-Options' => 'noopen',
    'X-Permitted-Cross-Domain-Policies' => 'none',
    'Referrer-Policy' => 'strict-origin-when-cross-origin'
  }

  config.action_dispatch.default_headers.merge!('X-UA-Compatible' => 'IE=edge')




  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }

    config.action_controller.enable_fragment_cache_logging = true
    # determines whether to log fragment cache reads and writes in verbose format
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end




  # I18n

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true
