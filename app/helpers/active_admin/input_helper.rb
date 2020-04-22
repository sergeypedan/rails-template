# frozen_string_literal: true

module ActiveAdmin::InputHelper

  include FnValidations

  def active_storage_file_input_hint(form, attachment_name, width: 250, height: 250)
    validate_argument_type! attachment_name, Symbol
    validate_argument_type! width,  Integer
    validate_argument_type! height, Integer

    attachment = form.object.public_send(attachment_name)
    return unless attachment.attached?

    transforma = lambda { |w, h| { resize: "#{w}x#{h}>" } }
    image_path = safe_variant_url(attachment, width: width, height: height, transform: transforma)

    return image_tag(image_path) if image_path
  end

end
