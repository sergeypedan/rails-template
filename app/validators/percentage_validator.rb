# frozen_string_literal: true

class PercentageValidator < ActiveModel::EachValidator

	MIN = 0
	MAX = 100

	def validate_each(record, attribute, value)
		record.errors.add attribute, :not_a_number                         and return unless value.is_a? Numeric
		record.errors.add attribute, :greater_than_or_equal_to, count: MIN and return if value < MIN
		record.errors.add attribute, :less_than_or_equal_to,    count: MAX and return if value > MAX
	end

end
