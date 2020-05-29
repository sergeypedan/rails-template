Devise.setup do |config|

  config.parent_mailer = 'ActionMailer::Base'

  config.mailer_sender = %(#{Rails.application.config.brand} <#{Rails.application.config.public_email}>)

  config.remember_for = 6.weeks

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.

  config.omniauth :facebook,
                  CONFIG[:FACEBOOK_APP_ID],
                  CONFIG[:FACEBOOK_APP_SECRET],
                  scope: 'email',
                  info_fields: 'id,email'
                  # token_params: { parse: :json }
                  #
                  # If you are seeing something like
                  # > Could not authenticate you from Facebook because “Invalid credentials”
                  # you may need to add token_params: { parse: :json } to your config

  # https://github.com/zquestz/omniauth-google-oauth2#configuration
  config.omniauth :google_oauth2,
                  CONFIG['GOOGLE_CLIENT_ID'],
                  CONFIG['GOOGLE_CLIENT_SECRET'],
                  image_aspect_ratio: 'square'

  config.omniauth :mail_ru,
                  CONFIG['MAILRU_APP_ID'],
                  CONFIG['MAILRU_APP_SECRET']

  # https://github.com/mamantoha/omniauth-vkontakte#configuring
  config.omniauth :vkontakte,
                  CONFIG[:VKONTAKTE_APP_ID],
                  CONFIG[:VKONTAKTE_APP_SECRET],
                  display: 'page',
                  https: 1,
                  image_size: 'bigger_x2',
                  lang: 'ru',
                  scope: 'email'

end
