class ApplicationController < ActionController::Base

	include DomainRedirect
	include LoginRedirects
	include BasicHTTPAuth
	include LocaleFromParams

end
