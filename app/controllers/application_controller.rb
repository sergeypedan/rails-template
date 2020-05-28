class ApplicationController < ActionController::Base

  CONTACT_DATA = {
    facebook: "https://www.facebook.com/mirkvestov.ru/",
    instagram: "https://www.instagram.com/mirkvestov/",
    vkontakte: "https://vk.com/mirkvestov_ru",
    google: "https://plus.google.com/communities/101227298505798127460",
    twitter: "https://twitter.com/mir_kvestov",
    phone: { raw: "+74993221524", formatted: "+7 (499) 322-15-24" },
    email_contact: "msk@mir-kvestov.ru",
    email_admin: "admin@mir-kvestov.ru",
    vk_ads_post_url: "https://vk.com/wall-109110067_6066"
  }.freeze

  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_USERNAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"], if: :protect_with_http_basic_auth?

  before_action :enforce_correct_domain
  before_action :set_contact_data
  before_action :enforce_correct_https_domain

  private

  def protect_with_http_basic_auth?
    Rails.env.production? && ENV["HTTP_BASIC_AUTH_USERNAME"].present? && ENV["HTTP_BASIC_AUTH_PASSWORD"].present?
  end

  def set_contact_data
    @contact_data = CONTACT_DATA
  end

  def enforce_correct_domain
    return unless Rails.env.production?
    unless request.original_url =~ /http:\/\/travel.mir-kvestov.ru\//
      redirect_to 'http://travel.mir-kvestov.ru' + request.fullpath
    end
  end

  def enforce_correct_https_domain
    redirect_to "https://#{Rails.application.config.domain}#{request.fullpath}" if should_redirect?
  end

  def should_redirect?
    return false unless Rails.env.production?
    return true unless request.ssl?
    return true if request.domain != Rails.application.config.domain  # herokuapp.com
    return true if request.subdomains.include? "www"                  # ["www"]
    return false
  end

end
