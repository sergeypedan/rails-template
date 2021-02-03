# frozen_string_literal: true

class JsonValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if value.nil?
    # return if value == "" no, because an empty String is not a valid JSON object

    # This will blow up if JSON is invalid
    parsed_value = JSON.parse! value

    # Enforcing type of contained data
    return unless type = options[:only]
    record.errors.add attribute, :invalid_format unless parsed_value.is_a? type

  rescue JSON::ParserError
    record.errors.add attribute, :invalid_format
  end

end
