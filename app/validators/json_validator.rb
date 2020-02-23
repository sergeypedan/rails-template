# frozen_string_literal: true

class JsonValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if value.blank? # presence validation should handle this
    JSON.parse(value)
  rescue JSON::ParserError
    record.errors.add attribute, :invalid_format
  end

end
