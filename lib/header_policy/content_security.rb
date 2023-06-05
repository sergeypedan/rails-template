# frozen_string_literal: true

module HttpHeaders
	class ContentSecurityPolicy < HttpHeaders::Base

		def call
			feature_strings.join(PARTS_SEPARATOR)
		end


		# Gathering values

		def feature_strings
			parts_hash.map do |key, value|
				[
					key.to_s.tr("_", "-"),
					value.join(VALUE_SEPARATOR)
				].join(PARAM_VALUE_SEPARATOR)
			end
		end

		def parts_hash
			{
					 connect_src: connect_src_values,
							base_uri:    base_uri_values,
					 default_src: compound_default_src_values,
							font_src:    font_src_values,
						 frame_src:   frame_src_values,
							 img_src:     img_src_values,
						 media_src:   media_src_values,
						object_src:  object_src_values,
					 # report_to:   report_to_values,
					# report_uri:  report_uri_values,
						script_src:  script_src_values,
						 style_src:   style_src_values
				# style_src_elem: style_scr_elem_values
			}
		end

		def compound_default_src_values
			(default_src_values + font_src_values + style_scr_elem_values).uniq
		end


		# Setting individual values

		def base_uri_values
			["'self'"]
		end

		def connect_src_values
			values = [
				"'self'",
				"https:",
				"clck.yandex.ru",
				"https://www.youtube.com",
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
				"https://embed.ted.com",
				"https://embed.ted.com/talks/*",
				"https://fonts.googleapis.com",
				"https://platform.twitter.com/embed/",
				"https://platform.twitter.com/widgets/",
				"https://player.vimeo.com",
				"https://www.instagram.com",
				"https://www.youtube.com"
			]
		end

		def font_src_values
			[
				"'self'",
				"https://fonts.googleapis.com",
				"https://fonts.gstatic.com"
			]
		end

		def frame_src_values
			[
				"https://www.youtube.com"
			]
		end

		def img_src_values
			[
				"'self'",
				"data:",
				"https:",
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
				"https://www.youtube.com/embed/*"
			]
		end

		def report_to_values
			[
				# "https://code2travelcom.report-uri.com/r/d/csp/enforce"
			]
		end

		def report_uri_values
			[
				# "https://code2travelcom.report-uri.com/r/d/csp/enforce"
			]
		end

		def script_src_values
			values = [
				"'self'",
				"'unsafe-inline'",
				"https:",
				"https://*.google-analytics.com",
				"https://mc.yandex.ru",
				"https://www.youtube.com"
			]
			values << "'unsafe-eval'" if Rails.env.development?
			values
		end

		def style_src_values
			[
				"'self'",
				"'unsafe-inline'",
				"https://fonts.googleapis.com"
			]
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
