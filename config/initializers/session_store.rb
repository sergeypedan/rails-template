# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
																				key: (Rails.env.production? ? "__Secure-session" : "_my_project_session"),
																				httponly: true,
																				same_site: :lax,
																				secure: Rails.env.production?
																				# expire_after: 14.days
