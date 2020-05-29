# frozen_string_literal: true

module SvgHelper

	include FnValidations

	def svg_placeholder(w: , h: , bg_color: "#dfdede")
		validate_argument_type! bg_color, String
		validate_argument_type! h, Numeric
		validate_argument_type! w, Numeric

		tag.svg(width: "#{w}px", height: "#{h}px", version: 1.1, viewBox: [0, 0, w, h].join(" "), xmlns: "http://www.w3.org/2000/svg", "xml:space": "preserve") do
			tag.rect x: 0, y: 0, width: w, height: h, style: "fill: #{bg_color}"
		end
	end
end

