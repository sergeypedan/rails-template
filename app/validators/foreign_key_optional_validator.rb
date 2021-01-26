# frozen_string_literal: true

class ForeignKeyOptionalValidator < ActiveModel::EachValidator

	MIN = 1

	def validate_each(record, attribute, value)
		vts = value.to_s
		return if vts == ""
		vti = value.to_i
		record.errors.add attribute, :not_an_integer and return if vts != vti.to_s
		record.errors.add attribute, :less_than, count: MIN and return if vti < MIN
	end

end
