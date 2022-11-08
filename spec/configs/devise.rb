RSpec.configure do |config|
	config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
