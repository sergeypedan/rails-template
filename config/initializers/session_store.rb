# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
																				key: (Rails.env.production? ? "__Secure-session" : "_my_project_session"),
																				httponly: true,
																				same_site: :lax,
																				secure: Rails.env.production?
																				# expire_after: 14.days

Rails.application.config.action_dispatch.cookies_same_site_protection = :lax
#
# Specify cookies SameSite protection level: either :none, :lax, or :strict.
# This change is not backwards compatible with earlier Rails versions.
# It's best enabled when your entire app is migrated and stable on 6.1.
