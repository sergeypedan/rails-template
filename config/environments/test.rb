Rails.application.configure do

  config.i18n.enforce_available_locales = false
  # to prefent Faker locale error
  # https://github.com/faker-ruby/faker/issues/278#issuecomment-519453199

  # https://prathamesh.tech/2020/08/10/creating-unlogged-tables-in-rails/
  config.to_prepare do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.create_unlogged_tables = true
    end
  end

  unless ENV["RAILS_ENABLE_TEST_LOG"]
	  config.logger = Logger.new(nil)
	  config.log_level = :fatal
	end

end
