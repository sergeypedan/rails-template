# frozen_string_literal: true

# How to use:
#
#  validates :url, presence: true, url: true
#  validates :url, presence: true, url: { only: :https }
#  validates :url, presence: true, url: { only: [:https, :ftp] }
#
class UrlValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, url)
		return if url.blank?
		record.errors.add attribute, :not_an_url and return unless uri = (URI.parse(url) rescue false)
		return unless protocol = options[:only]
		protocols = Array(protocol).map(&:to_s)
		record.errors.add attribute, :invalid_url_protocol, expected: protocols.map(&:upcase).map { |str| "«#{str.downcase}://»"}.to_sentence if protocols.none? { |protocol| uri.scheme == protocol }
	end

end

# ---
# ru:
#   errors:
#     format: "%{attribute} %{message}"
#     messages:
#       not_an_url: не является URL
#       invalid_url_protocol: имеет некорректный протокол URL, ожидается %{expected}
