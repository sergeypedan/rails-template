# frozen_string_literal: true

module BasicHTTPAuth

	extend ActiveSupport::Concern

	included do
		http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_USERNAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"], if: :protect_with_http_basic_auth?
	end

	private def protect_with_http_basic_auth?
		Rails.env.production? && ENV["HTTP_BASIC_AUTH_USERNAME"].present? && ENV["HTTP_BASIC_AUTH_PASSWORD"].present?
	end

end
