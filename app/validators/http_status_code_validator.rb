# frozen_string_literal: true

class HttpStatusCodeValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		return unless value
		record.errors.add attribute, :not_an_integer and return unless value.is_a? Integer
		record.errors.add attribute, :inclusion and return unless Net::HTTPResponse::CODE_TO_OBJ.keys.map(&:to_i).include? value
	end

end
