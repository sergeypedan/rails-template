# frozen_string_literal: true

class SpamValidator < ActiveModel::EachValidator

	def validate_each(record, attribute_name, value)
		return if value.blank?
		record.errors.add attribute_name, :spam if SpamWord.pluck(:word).any? { |word| value.downcase.include? word }
	end

end
