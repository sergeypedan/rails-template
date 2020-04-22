# frozen_string_literal: true

module HeaderPolicy
	class ContentSecurity < HeaderPolicy::Base

		def call
			feature_strings.join(PARTS_SEPARATOR)
		end

		def parts_hash
			{
					 connect_src: connect_src_values,
					 default_src: default_src_compound,
							font_src: font_src_values,
						 frame_src: frame_src_values,
							 img_src: img_src_values,
						 media_src: media_src_values,
						object_src: object_src_values,
						script_src: script_src_values
				# style_src_elem: style_scr_elem_values
			}
		end

		def feature_strings
			parts_hash.map do |key, value|
				[
					key.to_s.gsub("_", "-"),
					value.join(VALUE_SEPARATOR)
				].join(PARAM_VALUE_SEPARATOR)
			end
		end

		def connect_src_values
			values = [
				"'self'",
				"https:",
				"clck.yandex.ru",
				"http://www.youtube.com",
				"mail.yandex.ru",
				"mc.yandex.ru"
			]
			values <<   "ws://localhost:3035" if Rails.env.development?
			values << "http://localhost:3035" if Rails.env.development?
			values
		end

		def default_src_values
			[
				"'self'",
				"'unsafe-inline'",
				"https://fonts.googleapis.com"
			]
		end

    def default_src_compound
      (default_src_values + font_src_values + style_scr_elem_values).uniq
    end

		def font_src_values
			[
				"'self'",
				"https://fonts.gstatic.com"
			]
		end

		def frame_src_values
			[
				"http://www.youtube.com",
				"https://money.yandex.ru"
			]
		end

		def img_src_values
			[
				"'self'",
				"https:",
				"data:",
				"https://i.ytimg.com",
				"https://placehold.it"
			]
		end

		def media_src_values
			[
				"'self'"
			]
		end

		def object_src_values
			[
				"s4.money.yandex.net"
			]
		end

		def script_src_values
			values = [
				"'self'",
				"https:",
				"'unsafe-inline'",
				"http://www.youtube.com",
				"https://mc.yandex.ru",
				"https://*.google-analytics.com"
			]
			values << "'unsafe-eval'" if Rails.env.development?
			values
		end

		def style_scr_elem_values
			values = [
				"'self'",
				"https://fonts.googleapis.com"
			]
			values << "blob:" if Rails.env.development?
			values
		end

	end
end
