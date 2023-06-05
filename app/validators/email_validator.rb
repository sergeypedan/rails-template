# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator

	def validate_each(record, attribute_name, value)
		return if value.blank?
		record.errors.add attribute_name, :invalid_format unless value.match? URI::MailTo::EMAIL_REGEXP

		domains = Array(options[:domains])
		record.errors.add attribute_name, :invalid_domain, domains: domains if domains.any? && domains.none? { |domain| value.match? %r{@#{domain}$} }
	end

end

# Перевод нужно добавить в:
# activemodel:
#   errors:
#     messages:
#       invalid_format: некорректного формата
#       invalid_domain: недопустимый домен, разрешены только %{domains}
