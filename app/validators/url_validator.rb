# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors.add attribute, :invalid_format unless url_valid? value
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end

end
