# frozen_string_literal: true

require "pathname"

module ResponsivePictureHelper

  include FnValidations

  def picture_tag(img_path, formats: [], x2_res: true, classes: [], alt: nil)

    validate_argument_type! alt, [String, NilClass]
    validate_argument_type! img_path, String
    classes.each { |cl|  validate_argument_type! cl,  [String, Symbol] }
    formats.each { |ext| validate_argument_type! ext, [String, Symbol] }
    formats.each { |ext| fail(ArgumentError, "Provide extensions without dots: “#{ext.gsub(".", "")}” instead of “#{ext}”") if ext.include?(".") }

    pn = Pathname.new(img_path)                      # images/cat-1.jpg
    original_ext = pn.extname                        # ".jpg"
    path_noext = img_path.sub(original_ext, "").to_s # images/cat-1
    classes = nil if classes.empty?

    tag.picture class: classes do
      formats.each do |ext|
        concat tag.source(srcset: image_path("#{path_noext}.#{ext}"), type: "image/#{ext}")
      end
      concat image_tag(img_path, alt: alt)
    end
  end

end
