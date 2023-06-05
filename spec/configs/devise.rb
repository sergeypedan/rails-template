# https://github.com/heartcombo/devise#controller-tests

RSpec.configure do |config|
	config.include Warden::Test::Helpers
	config.include Devise::Test::ControllerHelpers, type: :controller
	config.include Devise::Test::ControllerHelpers, type: :view
	config.include Devise::Test::IntegrationHelpers, type: :feature
	# config.extend ControllerMacros, type: :controller
end

# sign_in @user
# sign_in @user, scope: :admin
