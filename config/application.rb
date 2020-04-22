require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.i18n.default_locale = :ru # не ru_RU
    config.i18n.available_locales = [:ru, :en]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.time_zone = "UTC"
    config.time_zone = "Moscow"

    config.active_record.default_timezone = :utc
    config.active_record.default_timezone = "Moscow"
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    # config.active_record.schema_format = :sql

    # API: http://edgeguides.rubyonrails.org/configuring.html#configuring-generators
    # Разъяснение http://rusrails.ru/configuring-rails-applications
    config.generators do |g|
      g.assets false
      g.channel assets: false
      g.controller_specs false
      g.factory_bot true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.helper false
      g.helper_specs false
      g.stylesheets false
      g.system_tests false
      g.view_specs false
      g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false, routing_specs: false, controller_specs: false, request_specs: false
    end

    config.paths.add "lib",      eager_load: true
    config.paths.add "services", eager_load: true
