# frozen_string_literal: true

require "active_model"

class DateValidator < ActiveModel::EachValidator

  REGEXP = /\d{4}-\d{2}-\d{2}/

  def validate_each(record, attribute, value)
    return if value.blank?
    record.errors.add(attribute, :invalid_format) and return unless REGEXP === value
    record.errors.add(attribute, :invalid) and return unless !!cast_to_date(value)
  end

  # @returns Date or nil
  private def cast_to_date(value)
    Date.parse(value) rescue nil
  end

end
