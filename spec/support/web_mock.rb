# frozen_string_literal: true

# gem "webmock", group: :test
require "webmock/rspec"

RSpec.configure do |config|
  config.before(:suite) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
