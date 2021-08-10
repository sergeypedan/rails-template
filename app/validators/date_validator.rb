# frozen_string_literal: true

# How to use:
#
#  validates :birth_day, date: true
#  validates :birth_day, date: { greater_than_or_equal_to: Date.new(1980, 12, 20), less_than_or_equal_to: Date.today }
#
class DateValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		return unless value

		record.errors.add :not_a_date and return unless value.respond_to?(:to_date)

		limit = options[:greater_than]
		if limit && !(value > limit)
			record.errors.add attribute, :greater_than, count: limit
		end

		limit = options[:greater_than_or_equal_to]
		if limit && !(value >= limit)
			record.errors.add attribute, :greater_than_or_equal_to, count: limit
		end

		limit = options[:less_than]
		if limit && !(value < limit)
			record.errors.add attribute, :less_than, count: limit
		end

		limit = options[:less_than_or_equal_to]
		if limit && !(value <= limit)
			record.errors.add attribute, :less_than_or_equal_to, count: limit
		end

		# is_correct = expected_types.include?(value.class)
		# record.errors.add attribute, :wrong_data_type, given: value.class, expected: expected_types.map(&:name).to_sentence unless is_correct
	end
end

# ---
# en:
#   errors:
#     format: "%{attribute} %{message}"
#     messages:
#       not_a_date: не является датой
