# frozen_string_literal: true

class ApplicationController < ActionController::Base

	include EnforceDomain
	include LoginRedirects
	include HttpBasicAuth
	include LocaleFromParams

end
