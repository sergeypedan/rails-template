# frozen_string_literal: true

module ActiveAdmin::InputHelper

	def active_storage_file_input_hint(form, attachment_name, width: 250, height: 250)
		attachment = form.object.public_send(attachment_name)
		img_url    = attachment.attachment&.variant(resize: "#{width}x#{height}>")
		return unless attachment.attached?
		image_tag img_url
	end

end
