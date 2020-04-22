# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  csp = HeaderPolicy::ContentSecurity.new
  separator = HeaderPolicy::VALUE_SEPARATOR

  policy.report_uri   "https://code2travelcom.report-uri.com/r/d/csp/enforce" # Specify URI for violation reports

  policy.connect_src  csp.connect_src_values.join(separator)
  policy.default_src  csp.default_src_compound.join(separator)
  policy.font_src     csp.font_src_values.join(separator)
  policy.img_src      csp.img_src_values.join(separator)
  policy.object_src   csp.object_src_values.join(separator)
  policy.script_src   csp.script_src_values.join(separator)
  policy.style_src    csp.font_src_values.join(separator)
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
