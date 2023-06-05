# frozen_string_literal: true

module GoogleFontsTagHelper

	ENDPOINT = "https://fonts.googleapis.com/css2".freeze
	WEIGHTS = [100, 200, 300, 400, 500, 600, 700, 800, 900].freeze

	# @param [Hash] fam
	# @raise [TypeError, ArgumentError]
	# @return String, "Montserrat:wght@100;200;300;400;500;600;700;800;900"
	#
	def url_params_family_value(fam)
		validate_argument_type! fam, Hash
		validate_argument_type! fam[:name], String
		regular_weights = validate_argument_type! (fam[:regular] || []), Array
		italic_weights  = validate_argument_type! (fam[:italic]  || []),  Array
		fail ArgumentError, "at least 1 weight must be present" if (regular_weights.size + italic_weights.size).zero?

		[regular_weights, italic_weights].each do |weights|
			weights.each do |weight|
				violator = weights.detect { |weight| !WEIGHTS.include?(weight) }
				fail ArgumentError, "a weight must be within the range from 100 up to 900, you pass #{violator}" if violator
			end
		end

		[
			"#{fam[:name].gsub(" ", "+")}:ital,wght",
			[
				regular_weights.map { |w| "0,#{w}" }.join(";"),
				italic_weights.map  { |w| "1,#{w}" }.join(";")
			].select(&:present?).join(";")
		].join("@")
	end

	# @return Hash like { family: "Montserrat:wght@100;200;300;400;500;600;700;800;900" }
	def url_params_family_group(fam)
		{ family: url_params_family_value(fam) }
	end


	# @return URI
	# @param [Array] config
	# @example
	#   [
	#   	{ name: "Montserrat",    regular: [300, 400, 500, 600], italic: [300, 400] },
	#   	{ name: "IBM Plex Sans", regular: [300, 400, 500, 600], italic: [300, 400] },
	#   ]
	#
	def google_fonts_link_tag_uri(config)
		URI.parse(ENDPOINT).tap do |uri|
			uri.query = [
				URI.encode_www_form({ display: "swap", subset: "cyrillic" }),
				config.map {
					URI.encode_www_form({ family: url_params_family_value(_1) })
				}.join("&")
			].join("&")
		end
	end

	# @return String
	def google_fonts_link_tag_url(config)
		CGI.unescape google_fonts_link_tag_uri(config).to_s
	end

	def google_fonts_link_tag(config)
		stylesheet_link_tag google_fonts_link_tag_url(config), crossorigin: :anonymous
	end

end
