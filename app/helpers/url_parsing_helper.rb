# frozen_string_literal: true

module UrlParsingHelper

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

  # Current URL: https://domain.com/articles/1?lang=en&sort=asc&from=landing
  #      `path`:                   /articles/1?lang=en&sort=asc  #=> true
  #      `path`:                   /articles/1?lang=en           #=> true
  #      `path`:                   /articles/1                   #=> true
  #      `path`:                   /articles/1?lang=en&sort=     #=> false
  #      `path`:                   /articles/1?lang=en&sort=desc #=> false
  #
  def current_url_includes_path_with_params?(path)
    [
      request.path.starts_with?(path.split("?").first),
      request_query_includes?(query_params_from_path(path))
    ].all?
  end

  # @param [String] path
  # @return [Hash] like { "scope" => "expiring" }
  def query_params_from_path(path)
    Rack::Utils.parse_nested_query(URI.parse(path).query)
  end

  # Check is current URL query params match all params and values you pass
  #
  # @param [Hash] query_params
  # @example
  #   { scope: :expiring }
  #   { scope: "expiring", "sort" => "asc" }
  #   { "scope" => "expiring", "sort" => "asc" }
  #
  def request_query_includes?(query_params)
    has_includes_subhash?(request.query_parameters, query_params.stringify_keys)
  end

  def has_includes_subhash?(hash, subhash)
    hash.slice(*subhash.keys).keys.all? { |key| hash.fetch(key) == subhash.fetch(key) }
  end

end
