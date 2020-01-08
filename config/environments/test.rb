Rails.application.configure do

  config.i18n.enforce_available_locales = false
  # to prefent Faker locale error
  # https://github.com/faker-ruby/faker/issues/278#issuecomment-519453199
end
