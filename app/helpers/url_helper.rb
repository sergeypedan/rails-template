# frozen_string_literal: true

module UrlHelper

	HTTP_PROTOCOL_REGEX = /https?:\/\//i


	# "https://yandex.ru" -> "https://yandex.ru"
	#  "http://yandex.ru" -> "http://yandex.ru"
	#         "yandex.ru" -> "http://yandex.ru"
	#                 ""  -> nil
	#                 nil -> nil
	def add_missing_http(url)
		return url if HTTP_PROTOCOL_REGEX === url
		"http://#{url}" if url.present?
	end


	def pretty_external_URL(url)
		CGI.unescape(url)
			 .sub(HTTP_PROTOCOL_REGEX, '')
			 .truncate(50, omission: '...')
	end


	# https://vk.com --> vk.com
	# http://vk.com  --> vk.com
	def strip_http(url)
		url.sub HTTP_PROTOCOL_REGEX, ""
	end

	def path_from_inspect
		[
			controller_name,
			action_name
		].join("/")
	end


	def strip_utm(string)
		keys_to_strip = ["utm_source", "utm_medium", "utm_campaign", "fbclid"]
		return string if string.nil?
		return string if string == ""
		validate_argument_type! string, String
		return string unless uri = (URI.parse string rescue nil)
		uri.query = Rack::Utils.parse_nested_query(uri.query).to_h.except(*keys_to_strip).to_query
		uri.to_s
	end

end
