# frozen_string_literal: true

module LoginRedirects

  # Default state: https://github.com/heartcombo/devise/blob/master/lib/devise/controllers/helpers.rb#L188
  #
  # def after_sign_in_path_for(resource_or_scope)
  #   stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
  # end


  # У Devise есть специальный механизм для редиректа на произвольный URL после логина: `store_location` / `stored_location`.
  # Это просто хелпер вокруг записи / чтения в `session` ключа (название которого определяется методом `stored_location_key_for(resource_or_scope)`),
  # где `resource_or_scope` это `@user` или `:user`.
  # https://www.rubydoc.info/github/plataformatec/devise/Devise/Controllers/StoreLocation
  # Тут мы его записываем из параметров URL — только на странице логина (SessionsController#new)
  #
  def save_redirect_path_in_session
    Rails.logger.debug "\ncontroller_name: #{controller_name}"
    Rails.logger.debug "stored_location_for(:user) : #{session[stored_location_key_for(:user)]}\n"

    # only at login / sign up pages
    return unless action_name == "new"
    return unless %w[registrations sessions].include?(controller_name)

    path = redirect_path_from_URL_params(request)
    Rails.logger.debug "\nWriting a cookie with redirect path: '#{path}'\n" if path.present?
    store_location_for(:user, path) if path.present?
  end


  # @returns a relative URL to redirect to from passed query param
  # (for links to pages beyond login wall from emails, for example)
  #
  # https://domain.ru/my/sign_in/?next=https://kazino.ru ->  nil
  # https://domain.ru/my/sign_in/?next=https://domain.ru ->  nil
  # https://domain.ru/my/sign_in/?next=/my/orders/1/edit -> "/my/orders/1/edit"
  # https://domain.ru/my/sign_in/?next=my/orders/1/edit  -> "/my/orders/1/edit"
  # https://domain.ru/my/sign_in/?next=                  ->  nil
  # https://domain.ru/my/sign_in/                        ->  nil
  #
  def redirect_path_from_URL_params(request)
    uri = URI.parse(request.query_parameters["next"].presence) rescue nil
    return unless uri
    return unless uri.relative?
    path = uri.to_s
    path.starts_with?("/") ? path : "/" + path
  end

end
