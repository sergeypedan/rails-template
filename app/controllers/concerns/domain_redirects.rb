# frozen_string_literal: true

module DomainRedirect

	extend ActiveSupport::Concern

	included do
		before_action :enforce_correct_domain
		before_action :enforce_correct_https_domain
	end

	def enforce_correct_domain
		return unless Rails.env.production?
		unless request.original_url =~ /http:\/\/travel.mir-kvestov.ru\//
			redirect_to 'http://travel.mir-kvestov.ru' + request.fullpath
		end
	end

	def enforce_correct_https_domain
		redirect_to "https://#{Rails.application.config.domain}#{request.fullpath}" if should_redirect?
	end

	def should_redirect?
		return false unless Rails.env.production?
		return true unless request.ssl?
		return true if request.domain != Rails.application.config.domain  # herokuapp.com
		return true if request.subdomains.include? "www"                  # ["www"]
		return false
	end

end
