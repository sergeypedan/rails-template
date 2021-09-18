# frozen_string_literal: true

module HttpBasicAuth

  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with  name: credentials.username,
                                  password: credentials.password,
                                  if: :protect_with_http_basic_auth?
  end

  def protect_with_http_basic_auth?
    Rails.env.production? && credentials.values.all?(&:present?)
  end

  def credentials
    {
      username: ENV["HTTP_BASIC_AUTH_USERNAME"],
      password: ENV["HTTP_BASIC_AUTH_PASSWORD"]
    }
  end

end
