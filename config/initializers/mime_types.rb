# https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/http/mime_types.rb
#
# def register(string, symbol, mime_type_synonyms = [], extension_synonyms = [], skip_lookup = false)
#
# https://api.rubyonrails.org/classes/Mime/Type.html#method-c-register


# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register "application/manifest+json", :webmanifest
Mime::Type.register "application/pdf", :pdf, [], %w(pdf)
Mime::Type.register "text/calendar", :ics
