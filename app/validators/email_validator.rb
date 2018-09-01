# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator

  REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def validate_each(record, attribute, value)
    is_valid = REGEXP === value
    record.errors.add attribute, :invalid_format unless is_valid
  end

end

# Перевод нужно добавить в:
# activemodel:
#   errors:
#     messages:
#       invalid_format: некорректного формата
