# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator

  REGEXP = %r{^https{0,1}://}i

  def validate_each(record, attribute_name, value)
    return if value.blank?
    record.errors.add attribute_name, :invalid_format unless REGEXP === value
  end

end
