# frozen_string_literal: true

module EnforceDomain

	extend ActiveSupport::Concern

	included do
    before_action :enforce_correct_domain, if: :should_enforce?
	end

	def enforce_correct_domain
		redirect_to "https://#{Rails.application.config.domain}#{request.fullpath}" if should_redirect?
	end

  def should_enforce?
    return false if ENV["ENFORCE_DOMAIN"] != "enabled"
    return false unless Rails.env.production?
    return true
  end

	def should_redirect?
		return true unless request.ssl?
		return true if request.domain != Rails.application.config.domain  # herokuapp.com
		return true if request.subdomains.include? "www"                  # ["www"]
		return false
	end

end
