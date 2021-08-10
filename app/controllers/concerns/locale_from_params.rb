# frozen_string_literal: true

module LocaleFromParams

	extend ActiveSupport::Concern

	included do
		before_action :set_locale_from_url_param
	end

	private def set_locale_from_url_param
		I18n.locale = (Array(params[:lang]&.to_sym) & I18n.available_locales).first || I18n.default_locale
	end

end
