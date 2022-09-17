# frozen_string_literal: true

module ExceptionHandling

	extend ActiveSupport::Concern

	included do
		# https://github.com/varvet/pundit#creating-custom-error-messages
		rescue_from Pundit::NotAuthorizedError,      with: :user_not_authorized
		rescue_from ActiveRecord::RecordNotFound,    with: :page_not_found_rescue
		rescue_from ActionController::RoutingError,  with: :page_not_found_rescue
		rescue_from ActionController::UnknownFormat do |exception| head :unsupported_media_type end
		rescue_from ActionController::InvalidAuthenticityToken do |exception| head :bad_request end
	end

	def page_not_found_rescue
		@block = ContentBlock.new(content_title: "Страница не найдена", text: "Страница не найдена")
		render "pages/text_page", status: :not_found
	end

end
