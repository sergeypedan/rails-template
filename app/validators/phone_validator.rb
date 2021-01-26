# frozen_string_literal: true

class PhoneValidator < ActiveModel::EachValidator

  # Allowed symbols: (0..9).map(&:to_s) + ['+', '-', ' ', '(', ')']

  MIN_LENGTH = 18
  MAX_LENGTH = 19

  FORMAT_EXAMPLE = '+7 (926) 111-11-11'.freeze

  def validate_each(record, attribute, value)
    return if value.blank? # presence should be checked separately

    disallowed_characters = value.gsub(' ', '').sub(/^\+/, "").gsub(/[\s\d\-\(\)]/, "")
    # We remove all allowed symbols from the incomins string (firstly we remove `+` only at the beginning of line)
    # if any characters remain, they are incorrect

    is_valid = (disallowed_characters == "")
    # And check that only "" is left. Otherwise, string is incorrect.

    too_short = value.length < MIN_LENGTH
    too_long  = value.length > MAX_LENGTH
    # checking phone length

    error_message = "содержит неразрешённые символы: «#{disallowed_characters}»"
    # We output those disallowed characters to error message

    #record.errors[attribute] << "имеет некорректный формат (не может быть короче #{MIN_LENGTH} символов)" if too_short
    #record.errors[attribute] << "имеет некорректный формат (не может быть длиннее #{MAX_LENGTH} символов)" if too_long
    record.errors[attribute] << "имеет неверный формат" if too_short || too_long
    record.errors[attribute] << (options[:message] || error_message) unless is_valid
  end
end
