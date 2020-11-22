# frozen_string_literal: true

module PriceHelper

  # От 100 ₽ до 5 000 ₽   verbose: true
  # 100 ₽ — 5 000 ₽       verbose: false
  # От 100 ₽
  # До 5 000 ₽
  def price_range_human(min, max, unit: "₽", verbose: false)
    fail ArgumentError, "Both prices must be Numeric or Nil" unless [min, max].compact.all? { |i| i.is_a? Numeric }
    options = { unit: unit }

    min_rub   = number_to_currency min, options
    max_rub   = number_to_currency max, options

    return "От #{min_rub} до #{max_rub}" if min && max && verbose
    return "#{min_rub} — #{max_rub}"     if min && max
    return "От #{min_rub}" if min
    return "До #{max_rub}" if max
  end

  # От 100 ₽ до 5 000 ₽   verbose: true
  # 100 ₽ — 5 000 ₽       verbose: false
  # От 100 ₽
  # До 5 000 ₽
  def range_human(min, max, unit: "₽", verbose: false, unit_on_1st: true)
    fail ArgumentError, "Both numbers must be either Numeric or Nil" unless [min, max].compact.all? { |i| i.is_a? Numeric }

    return nil if min.nil? && max.nil?

    min_unit = (unit.present? && unit_on_1st) ? "#{min} #{unit}" : min
    max_unit = unit.present? ? "#{max} #{unit}" : max

    return "От #{min_unit} до #{max_unit}" if min && max && verbose
    return "#{min_unit} — #{max_unit}"     if min && max
    return "От #{min_unit}" if min
    return "До #{max_unit}" if max
  end

end
