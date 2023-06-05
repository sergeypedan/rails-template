# frozen_string_literal: true

module CsrfLogger
  extend ActiveSupport::Concern

  included do
    before_action :trace_csrf_token_logic
  end

  # `encoded_msked_token` — that which is passed via params (or headers)
  # `msked_token` — token from params after Base64 decode
  #
  private def trace_csrf_token_logic

    expected_token_length = ActionController::RequestForgeryProtection::AUTHENTICITY_TOKEN_LENGTH
    is_urlsafe = Rails.application.config.action_controller.urlsafe_csrf_tokens

    Rails.logger.tagged("#{request.path} | CSRF config") do
      Rails.logger.debug "Forgery protection on? => #{allow_forgery_protection}"
      Rails.logger.debug "Tokens URL-safe? => #{is_urlsafe}"
      Rails.logger.debug "Per-form CSRF tokens? => #{per_form_csrf_tokens}"
      Rails.logger.debug "Token length => #{expected_token_length}"
    end

    Rails.logger.debug ""

    Rails.logger.tagged("#{request.path} | CSRF origin") do
      Rails.logger.debug "Origin check is on? => #{Rails.application.config.action_controller.forgery_protection_origin_check}"
      Rails.logger.debug "request.origin => #{request.origin.inspect}"
      Rails.logger.debug "request.base_url => #{request.base_url}"
      if request.origin
        Rails.logger.debug "valid_request_origin? => #{request.origin == request.base_url}"
      else
        Rails.logger.debug "valid_request_origin? => true (request.origin was nil, which is considered OK)"
      end
    end

    Rails.logger.debug ""

    Rails.logger.tagged("#{request.path} | CSRF passed") do
      Rails.logger.debug "No token passed nor via header nor via params, no point in proceeding" and return if request_authenticity_tokens.empty?
    end

    Rails.logger.tagged("#{request.path} | CSRF in session") do
      if session[:_csrf_token].blank?
        Rails.logger.debug "No token in session, no point in proceeding"
        Rails.logger.debug "↑ If this endpoint (#{request.path}) is CSRF-protected, this is what is causing the 422 response status"
        Rails.logger.debug "Session contents: #{session.to_h}"
        Rails.logger.debug "Cookies: #{request.headers.to_h["HTTP_COOKIE"]}"
        return
      end
    end

    real_csrf_token_from_session = is_urlsafe ? Base64.urlsafe_decode64(session[:_csrf_token]) : Base64.strict_decode64(session[:_csrf_token])
    global_csrf_token = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, real_csrf_token_from_session, "!real_csrf_token")
    per_form_token = correct_per_form_token(real_csrf_token_from_session)

    Rails.logger.debug ""
    Rails.logger.tagged("#{request.path} | CSRF in session") do
      Rails.logger.debug "Token in session => #{session[:_csrf_token]}"
      Rails.logger.debug "Global CSRF token (from session) => #{global_csrf_token}\n"
      Rails.logger.debug "Token decoded from session => #{real_csrf_token_from_session}"
      Rails.logger.debug "Correct per-form token => #{per_form_token} (from session + controller/action names)"
    end

    Rails.logger.debug ""
    Rails.logger.tagged("#{request.path} | CSRF in params") do
      Rails.logger.debug "Tokens passed via form or headers => #{request_authenticity_tokens}"
      Rails.logger.debug "Token passed in form => #{form_authenticity_param.inspect}"
      Rails.logger.debug "Token passed in headers => #{request.x_csrf_token.inspect}"
      Rails.logger.debug "↑ If this endpoint (#{request.path}) is CSRF-protected, this is what is causing the 422 response status" if request_authenticity_tokens.none?
    end

    Rails.logger.debug ""
    Rails.logger.tagged("#{request.path} | Header") do
      output_headers.each do |key, value|
        Rails.logger.debug "“#{key}” => #{value}"
      end
    end

    request_authenticity_tokens.select(&:present?).each_with_index do |encoded_msked_token, index|
      via = if index == 1 then "header" else form_authenticity_param.present? ? "param" : "header" end
      Rails.logger.tagged("#{request.path} | Check CSRF in #{via}") do
        Rails.logger.debug "Encoded masked token => #{encoded_msked_token}"
        msked_token = is_urlsafe ? Base64.urlsafe_decode64(encoded_msked_token) : Base64.strict_decode64(encoded_msked_token)
        Rails.logger.debug "Decoded masked token => #{msked_token}\n"
        # Rails.logger.debug "Any authenticity token valid? => #{any_authenticity_token_valid?}"

        case msked_token.length
        when expected_token_length * 2
          Rails.logger.debug "Token is double-length (this is correct behavior)"
          unmsked_token = copy_of_unmask_token(msked_token)
          Rails.logger.debug "Unmasked token => #{unmsked_token}"
          glb_result = ActiveSupport::SecurityUtils.fixed_length_secure_compare(unmsked_token, global_csrf_token)
          rst_result = ActiveSupport::SecurityUtils.fixed_length_secure_compare(unmsked_token, real_csrf_token_from_session)
          pfr_result = per_form_csrf_tokens ? (ActiveSupport::SecurityUtils.fixed_length_secure_compare(unmsked_token, per_form_token)) : false
          Rails.logger.debug "Compare with global token => #{glb_result}"
          Rails.logger.debug "Compare with real token => #{rst_result}"
          Rails.logger.debug "Valid per-form token? => #{pfr_result}"
          Rails.logger.debug "Any token matched? => #{[glb_result, rst_result, pfr_result].any?}"
        when expected_token_length
          Rails.logger.debug "Token is single-length (this behavior is correct only shortly after upgrade to masked tokens)"
          unmsked_token = msked_token
          Rails.logger.debug "Token matched? => #{ActiveSupport::SecurityUtils.fixed_length_secure_compare(unmsked_token, real_csrf_token_from_session)}"
        else
          Rails.logger.debug "Token is wrong lengh: #{msked_token.length}) thus malformed. Allowed length: #{expected_token_length} or #{expected_token_length * 2}"
        end
      end
    end
  end


  private def copy_of_unmask_token(msked_token)
    # Split the token into the one-time pad and the encrypted value and decrypt it.
    token_length         = ActionController::RequestForgeryProtection::AUTHENTICITY_TOKEN_LENGTH
    one_time_pad         = msked_token[0...token_length]
    encrypted_csrf_token = msked_token[token_length..-1]
    xor_byte_strings(one_time_pad, encrypted_csrf_token)
  end

  private def correct_per_form_token(real_csrf_token_from_session)
    return nil unless per_form_csrf_tokens

    action_path    = request.path.chomp("/")
    request_method = request.request_method.downcase
    identifier     = [action_path, request_method].join("#")
    OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, real_csrf_token_from_session, identifier)
  end

  # `headers` gives much fewer headers than `request.headers`
  private def output_headers
    request.headers.to_h
      .reject { |k, v| k.starts_with? "action_controller" }
      .reject { |k, v| k.starts_with? "action_dispatch" }
      .reject { |k, v| k.starts_with? "puma" }
      .except("rack.errors")
      .except("rack.hijack")
      .except("rack.input")
      .except("rack.cors")
      .except("rack.request.cookie_string") # same as HTTP_COOKIE
      .except("rack.session")
      .except("rack.session.options")
      .reject { |key, value| key.include? "action_controller" }
      .sort_by { |k, v| k }
  end

end
