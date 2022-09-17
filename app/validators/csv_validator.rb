# frozen_string_literal: true

require "csv"

class CsvValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? # presence validation should handle this

    value = sanitize_utf8(value)
    parsed_csv = ::CSV.parse(value) # can raise MalformedCSVError

    headers = parsed_csv[0]

    parsed_csv.drop(1).each do |row|
      [headers, row].transpose.to_h # can raise IndexError
    end

    validate_missing_headers!(headers, record, attribute)
    validate_extra_headers!(headers, record, attribute)

  rescue ::CSV::MalformedCSVError
    record.errors.add attribute, :unparseable, mime: "CSV"
  rescue IndexError
    record.errors.add attribute, "has different number of columns and headers"
  end

  private

  def validate_missing_headers!(csv_headers, record, attribute)
    missing_headers = Array(options[:headers]) - csv_headers
    return if missing_headers.none?
    record.errors.add attribute, error_msg("has missing headers", missing_headers)
  end

  def validate_extra_headers!(csv_headers, record, attribute)
    return unless options[:prohibit_extra_headers]
    extra_headers = csv_headers - Array(options[:headers])
    return if extra_headers.none?
    record.errors.add attribute, error_msg("must not contain headers", extra_headers)
  end

  def error_msg(start_str, headers)
    start_str + ": " + quote_headers(headers).to_sentence
  end

  def quote_headers(array)
    array.map { "“#{_1}”" }
  end

  def sanitize_utf8(txt)
    txt.to_s.force_encoding(Encoding::UTF_8).sub("\xEF\xBB\xBF", "")
  end
end
