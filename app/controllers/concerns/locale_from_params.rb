# frozen_string_literal: true

module LocaleFromParams

	extend ActiveSupport::Concern

	included do
		before_action :set_locale
		after_action  :save_locale_in_session
	end

	private

	def save_locale_in_session
		session[:locale] = I18n.locale
	end

	def set_locale
		I18n.locale = [params[:lang], session[:locale], I18n.default_locale]
										.select(&:present?)
										.map(&:to_sym)
										.reject { |loc| !I18n.available_locales.include?(loc) }
										.first
	end

end
