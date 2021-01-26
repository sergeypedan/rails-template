# frozen_string_literal: true

class CounterValidator < ActiveModel::EachValidator

  MIN = 0

  def validate_each(record, attribute, value)
    vti = value.to_i
    vts = value.to_s
    record.errors.add attribute, :empty and return if vts == ""
    record.errors.add attribute, :not_an_integer and return if vts != vti.to_s
    record.errors.add attribute, :less_than, count: MIN and return if vti < MIN
  end

end
