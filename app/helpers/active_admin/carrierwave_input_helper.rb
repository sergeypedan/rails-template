# frozen_string_literal: true

module ActiveAdmin::CarrierwaveInputHelper

	# @param [Symbol] attr
	def aa_carrier_wave_input(attr, fb)
		fail TypeError, "`attr` must be a Symbol, not a #{attr.class}" unless attr.is_a? Symbol
		fail TypeError, "`fb` must be a ActiveAdmin::FormBuilder, not a #{fb.class}" unless fb.is_a? ActiveAdmin::FormBuilder

		record = fb.object
		attachment = record.public_send(attr)
		hint = (image_tag(attachment.url(:admin), alt: "Preview") if record.persisted? && attachment.url)
		fb.input attr, as: :file, hint: hint
	end

end
