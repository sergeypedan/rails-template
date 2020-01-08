# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator

  REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  DISPOSABLE_EMAIL_SERVICE_DOMAINS = [
    "emailcu.icu",        # mohmal.com
    "enayu.com",
    "grr.la",             # guerrillamail
    "guerrillamail.biz",  # guerrillamail
    "guerrillamail.com",  # guerrillamail
    "guerrillamail.de",   # guerrillamail
    "guerrillamail.info", # guerrillamail
    "guerrillamail.net",  # guerrillamail
    "guerrillamail.org",  # guerrillamail
    "guerrillamailblock.com",
    "opka.org",
    "optimaweb.me",     # tempmailo.com
    "pokemail.net",
    "privacy-mail.top", # temp-mail.io
    "sharklasers.com",  # guerrillamail
    "spam4.me"          # guerrillamail
  ].freeze

  def validate_each(record, attribute_name, value)
    return if value.blank?
    record.errors.add attribute_name, :invalid_format unless REGEXP === value
    record.errors.add attribute_name, :disposable_email if DISPOSABLE_EMAIL_SERVICE_DOMAINS.any? { |domain| value.include? domain }
  end

end

# Перевод нужно добавить в:
# activemodel:
#   errors:
#     messages:
#       invalid_format: некорректного формата
#       disposable_email: в сервисе одноразовых email-адресов
