# frozen_string_literal: true

class AngleValidator < ActiveModel::EachValidator

	MIN = -360
	MAX =  360

	def validate_each(record, attribute, value)
		return if value.blank?
		record.errors.add attribute, :greater_than, count: MIN and return if value.to_i < MIN
		record.errors.add attribute, :less_than,    count: MAX and return if value.to_i > MAX
	end

end
