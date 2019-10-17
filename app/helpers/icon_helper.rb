# frozen_string_literal: true

module IconHelper

  def boolean_checkbox_for(bool)
    fa_icon "#{ 'check-' if bool }square-o"
  end


  def boolean_input_checkbox_for(bool)
    check_box_tag "active", 1, bool, { id: nil }
  end


  def boolean_eye_for(bool)
    fa_icon bool ? "eye" : "eye-slashed"
  end

end
