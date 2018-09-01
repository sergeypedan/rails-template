  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = "https://#{Rails.application.credentials.domain}"
  config.action_mailer.asset_host     = "https://#{Rails.application.credentials.domain}"


  # SSL

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true


