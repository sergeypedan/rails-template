require "capybara/rails"
require "capybara/rspec"
# require "selenium-webdriver"
# require "capybara-screenshot/rspec"


Capybara.always_include_port   = true
Capybara.app_host              = "http://localhost"
Capybara.asset_host            = "http://localhost:3000"
Capybara.default_host          = "http://localhost"
Capybara.default_max_wait_time = 5
Capybara.javascript_driver     = :headless_chrome # :selenium by default
Capybara.run_server            = true
Capybara.server                = :puma, { Silent: true, Threads: "1:1" }
Capybara.server_host           = "localhost"
Capybara.server_port           = 3000


Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
	args = %w(headless disable-gpu window-size=1024,768 no-sandbox disable-dev-shm-​usage)
  # on `disable-gpu` option:
  # The documentation for the headless Chrome indicates this is only temporarily necessary but does not specify why.
  # It’s not clear if this is necessary now that the feature is stable
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args })
  Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities
end

# Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
#   driver.browser.save_screenshot(path)
# end
