require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# All available config options with descriptions: https://guides.rubyonrails.org/configuring.html

		config.middleware.use Rack::Deflater
		config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
		# https://dev.to/onlyoneaman/how-to-make-rails-response-faster-19ff#3b6e
		#
		# If you are using ActionDispatch::Static in your app. Then,Rack::Deflater should be placed after ActionDispatch::Static.
		# The reasoning is that if your app is also serving static assets (e.g., Heroku), when assets are served from disk they are already compressed.
		# Inserting it before would only end up in Rack::Deflater attempting to re-compress those assets.

		# Initialize configuration defaults for originally generated Rails version.
		# https://github.com/rails/rails/blob/main/guides/source/configuring.md#default-values-for-target-version-71
		config.load_defaults 6.1

		config.brand  = "Code to travel"
		config.domain = "code2travel.com"
		config.email  = "support@code2travel.com"

		config.i18n.default_locale = :ru # не ru_RU
		config.i18n.available_locales = [:ru, :en]
		config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

		config.time_zone = "UTC"
		config.time_zone = "Moscow"

		config.active_record.default_timezone = :utc
		config.active_record.default_timezone = "Moscow"
		config.active_record.default_timezone = :local
		config.active_record.time_zone_aware_attributes = false
		# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
		# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.

		# config.active_record.schema_format = :sql

		# API: http://edgeguides.rubyonrails.org/configuring.html#configuring-generators
		# Разъяснение http://rusrails.ru/configuring-rails-applications
		config.generators do |g|
			g.assets false
			g.channel assets: false
			g.controller_specs false
			g.factory_bot dir: "spec/factories"
			g.fixture_replacement :factory_bot
			g.helper false
			g.helper_specs false
			g.integration_tool :rspec
			g.javascript_engine :js
			g.stylesheets false
			g.system_tests false
			g.template_engine :slim
			g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false, routing_specs: false, controller_specs: false, request_specs: false
			g.view_specs false
		end

		config.paths.add "lib",      eager_load: true
		config.paths.add "services", eager_load: true

		config.add_autoload_paths_to_load_path = false
		# https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#$load-path

		# systemd: SystemMaxUse or SystemKeepFree
		# ls -lahF log
		# https://github.com/rails/rails/pull/44888
		config.log_file_size = 104_857_600

		Rails.autoloaders.main.ignore Rails.root.join('app', 'junkyard')
		ActiveSupport::Dependencies.autoload_paths.delete("#{Rails.root}/app/api") # https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#having-app-in-the-autoload-paths

		config.add_autoload_paths_to_load_path = false
		# https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-add-autoload-paths-to-load-path

		config.to_prepare do
			Devise::Mailer.layout "mailer"
		end

	end
