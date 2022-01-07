# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator

	REGEXP = URI::MailTo::EMAIL_REGEXP

	def validate_each(record, attribute_name, value)
		return if value.blank?
		record.errors.add attribute_name, :invalid_format unless value.match? REGEXP
	end

end

# Перевод нужно добавить в:
# activemodel:
#   errors:
#     messages:
#       invalid_format: некорректного формата
#       disposable_email: в сервисе одноразовых email-адресов
