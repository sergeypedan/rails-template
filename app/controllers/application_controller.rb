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

  before_action :enforce_correct_domain
  before_action :set_contact_data

  private

  def set_contact_data
    @contact_data = CONTACT_DATA
  end

  def enforce_correct_domain
    return unless Rails.env.production?
    unless request.original_url =~ /http:\/\/travel.mir-kvestov.ru\//
      redirect_to 'http://travel.mir-kvestov.ru' + request.fullpath
    end
  end

end
