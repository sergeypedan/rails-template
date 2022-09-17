# This file is copied to spec/ when you run 'rails generate rspec:install'

require 'spec_helper'

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in #{Rails.env} mode!") unless Rails.env.test?

require 'rspec/rails'

# Requiring config files from `spec/support`
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }


# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

ActionDispatch::SystemTesting::Server.silence_puma = true

RSpec.configure do |config|

  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures

  config.before(:suite) do
    # FactoryBot.reload
    Rails.application.load_tasks
    Rake::Task["db:purge"].invoke
    Rake::Task["db:schema:load"].invoke
    # Rake::Task["db:structure:load"].invoke
    FactoryBot.lint # creates each factory and catches any exceptions raised
    load "#{Rails.root}/db/seeds.rb"
  end

  config.before(:all, type: :request) do
    # default_url_options[:host] = "localhost"
    # default_url_options[:host] = Rails.application.credentials.domain

    # host! "localhost"
    # host! Rails.application.credentials.domain
  end

  # config.after(:suite) do
  #   Sidekiq::Queue.all do |queue|
  #     queue.clear
  #   end

  #   Sidekiq::RetrySet.new.clear
  # end

  config.use_transactional_fixtures = true
  # If you're not using ActiveRecord, or you'd prefer not to run each of your examples within a transaction, remove the following line or assign false instead of true.

  config.infer_spec_type_from_file_location!
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs

  config.filter_rails_from_backtrace!
  # Filter lines from Rails gems in backtraces.

  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.extend ControllerMacros, type: :controller

  config.include ViewComponent::TestHelpers, type: :component

end
