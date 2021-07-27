# frozen_string_literal: true

# How to use:
#
#  validates :url, presence: true,  data_type: { only: String }
#  validates :url, allow_nil: true, data_type: { only: [String, Symbol] }
#
class DataTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    expected_types = Array(options[:only])
    is_correct = expected_types.include?(value.class)
    record.errors.add attribute, :wrong_data_type, given: value.class, expected: expected_types.map(&:name).to_sentence unless is_correct
  end
end

# ---
# en:
#   errors:
#     format: "%{attribute} %{message}"
#     messages:
#       wrong_data_type: "is of wrong type: you pass a %{given}, expected are: %{expected}"
