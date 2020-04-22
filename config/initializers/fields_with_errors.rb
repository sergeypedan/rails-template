# frozen_string_literal: true

# Stops Rails from wrapping inputs & labels of fields with errors into `div.field_with_errors`
# from https://coderwall.com/p/s-zwrg/remove-rails-field_with_errors-wrapper
# and https://gist.github.com/telwell/db42a4dafbe9cc3b7988debe358c88ad
#
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
