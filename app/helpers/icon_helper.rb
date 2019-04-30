# frozen_string_literal: true

module IconHelper

  def boolean_checkbox_for(param)
    fa_icon "#{ 'check-' if param }square-o"
  end


  def boolean_input_checkbox_for(is_true)
    check_box_tag "active", 1, is_true, { id: nil }
  end


  def boolean_eye_for(is_true)
    fa_icon is_true ? "eye" : "eye-slashed"
  end

end
