# All config options:
# https://github.com/formtastic/formtastic/blob/master/lib/generators/templates/formtastic.rb

# http://github.com/formtastic/formtastic/README.md~Enhanced Localization
Formtastic::FormBuilder.i18n_lookups_by_default = true

# Opt-in to Formtastic's use of the HTML5 `required` attribute on `<input>`, `<select>` d `<textarea>` tags
Formtastic::FormBuilder.use_required_attribute = true

# Opt-in to new HTML5 browser validations (for things like email and url inputs).
# Doing so will omit the `novalidate` attribute from the `<form>` tag.
# See http://diveintohtml5.org/forms.html#validation for more info.
Formtastic::FormBuilder.perform_browser_validations = true
