# frozen_string_literal: true

module OauthHelper

  # extracts `?redirect_to=` value from social nets callback URL (request.env['omniauth.origin'])
  # @returns nil if not found
  def redirect_path_from_oauth(request_env)
    return unless request_env.is_a? Hash

    # Some social nets may pass the whole URL including query params
    origin_url       = request_env["omniauth.origin"] # String or nil
    query_string     = URI.parse(origin_url.to_s).query # String ("param=value") or nil
    origin_params    = URI.decode_www_form(query_string.to_s).to_h # { "param" => "value" } or {}

    # Facebook does not include query params into `request.env['omniauth.origin']`, but we can get it from `request.env["omniauth.params"]`
    omniauth_params = request_env["omniauth.params"] || {} # { "redirect_to" => "/quests/..." }

    path = origin_params["redirect_to"].presence || omniauth_params["redirect_to"].presence  # No empty strings
    return unless path

    # validating path
    uri = URI.parse(path) rescue nil  # URI.parse will raise an error on incorrect URLs, which we do not want
    return if uri.blank?     # Some incorrect URIs will still be parsed to an empty String
    return if uri.absolute?  # Security precation

    uri.to_s
  end

end
