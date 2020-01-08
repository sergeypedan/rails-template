# frozen_string_literal: true

module EmailHelper

  GOOGLE_EMAIL_REGEXP = /\A([^@]*)@(gmail.com|googlemail.com)\z/i

  def google_email?(email)
    GOOGLE_EMAIL_REGEXP === email
  end

  def extract_google_email_alias(email)
    return unless google_email? email
    username, domain = email.scan(GOOGLE_EMAIL_REGEXP).flatten
    username.gsub!('.', '')
    username.gsub!(/\+.*/, '')
    [username, domain].join("@")
  end

end
