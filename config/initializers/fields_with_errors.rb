# Removing `.field_with_errors` wrappers around inputs & labels of fields with errors
# https://coderwall.com/p/s-zwrg/remove-rails-field_with_errors-wrapper

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
