# frozen_string_literal: true

class PasswordValidator < ActiveModel::EachValidator

	LENGTH = Devise.password_length
	# REGEXP = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])$/

	def validate_each(record, attribute_name, value)
		record.errors.add attribute_name, :blank and return         unless value.present?
		record.errors.add attribute_name, :insufficient_length      unless LENGTH.include? value.length
		record.errors.add attribute_name, :lacks_special_charactess unless /[#?!@$%^&*-;:,.~`]/ === value
		record.errors.add attribute_name, :lacks_integers           unless /[0-9]/ === value
		record.errors.add attribute_name, :lacks_uppercase_letter   unless /[A-Z]/ === value
		record.errors.add attribute_name, :lacks_lowercase_letter   unless /[a-z]/ === value
	end

end
