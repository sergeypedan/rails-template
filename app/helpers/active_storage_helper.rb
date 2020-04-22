# frozen_string_literal: true

module ActiveStorageHelper

  include FnValidations

  # @returns image URL (String) or Nil
  #
  def safe_variant_url(attachment, width:, height:, transform: lambda { |w, h| nil})
    validate_argument_type! attachment, ActiveStorage::Attached::One
    validate_argument_type! width,  Integer
    validate_argument_type! height, Integer

    return unless attachment.attached?

    transformation = transform.call(width, height)
    variant        = attachment.variant(transformation)
    return rails_representation_path(variant.processed)

  rescue ActiveStorage::FileNotFoundError => error
    Rails.logger.warn("`#{attachment.record.class.name.downcase.to_sym}.#{attachment.name}.attached?` is true, but `rails_representation_path(variant.processed)` raises a FileNotFoundError")
    return
  rescue MiniMagick::Error => error
    Rails.logger.warn("raises a MiniMagick::Error: #{error}")
    return
  end

end
