# frozen_string_literal: true

# How to use:
#
#  validates :url, presence: true, url: true
#  validates :url, presence: true, url: { only: :https }

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if value.blank?
    record.errors.add attribute, :invalid_format unless url_valid? value
  end

  private def url_valid?(url)
    case uri = URI.parse(url) rescue false
    when URI::HTTPS then options.has_key? :only ? options[:only] == :https : true
    when URI::HTTP  then options.has_key? :only ? options[:only] == :http  : true
    else false
    end
  end

end
