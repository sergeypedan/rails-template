# frozen_string_literal: true

class ApplicationController < ActionController::Base

	# protect_from_forgery prepend: true

	include EnforceDomain
	include LoginRedirects
	include HttpBasicAuth
	include LocaleFromParams
	include CsrfLogger

end
