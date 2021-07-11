# frozen_string_literal: true

class AdditionalPaymentJsonValidator < ActiveModel::EachValidator

  ATTRIBUTES = [
    { name: "description",   type: String,  required: false },
    { name: "max_counter",   type: Integer, required: true  },
    { name: "min_counter",   type: Integer, required: true  },
    { name: "name",          type: String,  required: true  },
    { name: "price_per_one", type: Integer, required: true  }
  ]

  def validate_each(record, attribute, value)
    return if value.to_s.blank? # presence validation should handle this

    parsed = JSON.parse(value.to_s)

    record.errors.add attribute, "корневым элементом должен быть массив" and return unless parsed.is_a? Array

    required_attributes.each do |attr_name|
      values = parsed.map { |hash| hash[attr_name] }
      record.errors.add attribute, "в каждой опции должен быть параметр \"#{attr_name}\"" unless parsed.all? { |hash| hash.has_key? attr_name }
      record.errors.add attribute, "в параметре \"#{attr_name}\" каждой опции должно быть значение типа #{type_of(attr_name)}" if values.any?(&:blank?)
    end

    integer_attributes.each do |attr_name|
      values = parsed.map { |hash| hash[attr_name] }
      record.errors.add attribute, "значение \"#{attr_name}\" должно быть типа Integer во всех записях" if values.grep_v(Integer).any?
    end

    parsed.each do |hash|
      if [hash["min_counter"], hash["max_counter"]].grep_v(Integer).none?
        record.errors.add(attribute, "\"max_counter\" должен быть >= \"min_counter\" во всех записях") and return unless hash["max_counter"] >= hash["min_counter"]
      end
    end

    record.errors.add(attribute, "параметр \"description\" не должен содержать HTML ни в одной из записей") and return if parsed.map { |hash| hash["description"] }.any? { |description| contains_html? description }

  rescue JSON::ParserError
    record.errors.add attribute, :invalid_format
  end

  private

  def required_attributes
    ATTRIBUTES.select { |attr| attr[:required] }.map { |attr| attr[:name] }
  end

  def integer_attributes
    ATTRIBUTES.select { |attr| attr[:type] == Integer }.map { |attr| attr[:name] }
  end

  def type_of(name)
    ATTRIBUTES.find { |attr| attr[:name] == name }[:type]
  end

  def contains_html?(string)
    %r{<\w+} === string || %r{</\w+} === string
  end

end
