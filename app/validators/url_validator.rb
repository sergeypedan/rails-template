# frozen_string_literal: true

# How to use:
#
#  validates :url, presence: true, url: true
#  validates :url, presence: true, url: { only: :https }
#  validates :url, presence: true, url: { only: [:https, :ftp] }
#
class UrlValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, url)
		return if url.blank? # leave this check for `presence: true`
		record.errors.add attribute, :not_an_url and return unless uri = (URI.parse(url) rescue false)
		return if allowed_protocols.none?
		return if allowed_protocols.any? { |protocol| uri.scheme == protocol }
		record.errors.add attribute, :invalid_url_protocol, expected: error_mgs(allowed_protocols)
	end

	private def allowed_protocols
		Array(options[:only]).compact.map(&:to_s)
	end

	private def error_mgs(protocols)
		protocols.map(&:downcase).map { "«#{_1}://»" }.to_sentence
	end

end

# ---
# ru:
#   errors:
#     format: "%{attribute} %{message}"
#     messages:
#       not_an_url: не является URL
#       invalid_url_protocol: имеет некорректный протокол URL, ожидается %{expected}
