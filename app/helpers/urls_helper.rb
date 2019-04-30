# frozen_string_literal: true

module UrlsHelper

	# https://vk.com --> vk.com
	# http://vk.com  --> vk.com
	def un_http(url)
		url.sub(/(http|https):\/\//, '')
	end

end
