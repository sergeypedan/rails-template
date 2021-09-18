# Stops Rails from wrapping inputs & labels of fields with errors into `div.field_with_errors`
# from https://coderwall.com/p/s-zwrg/remove-rails-field_with_errors-wrapper
# and https://gist.github.com/telwell/db42a4dafbe9cc3b7988debe358c88ad
#
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	if html_tag.match? %r{<label}
		html_tag
	else
		class_attr_index = html_tag.index %{class="}
		# Does the field already have a `class` attribute.
		# If it does, we’ll get the index where `class="` is in the raw HTML string.

		invalid_css_class = "is-invalid"

		if class_attr_index
			html_tag.insert (class_attr_index + 7), "#{invalid_css_class} "
			# append invalid_css_class to the beginning of the classes list
		else
			html_tag.insert html_tag.index('>'), %{ class="#{invalid_css_class}"}
			# insert the entire class attribute assignment right before we close the tag
		end

		[
			html_tag,
			%{<span class="invalid-feedback">#{Array(instance.error_message).join(",")}</span>}
		].join(" ").html_safe
	end
end
