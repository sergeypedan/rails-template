# frozen_string_literal: true

module LoginRedirects

  # Default state: https://github.com/heartcombo/devise/blob/master/lib/devise/controllers/helpers.rb#L188
  #
  # def after_sign_in_path_for(resource_or_scope)
  #   stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
  # end


  # У Devise есть специальный механизм для редиректа на произвольный URL после логина: `store_location` / `stored_location`.
  # Это просто хелпер вокруг записи / чтения в `session` ключа (название которого определяется методом `stored_location_key_for(resource_or_scope)`).
  # https://www.rubydoc.info/github/plataformatec/devise/Devise/Controllers/StoreLocation
  # Тут мы его записываем из параметров URL
  #
  def write_redirect_path
    return unless controller_name == "sessions" && action_name == "new" # only at login page
    path = redirect_path_from_URL_params(request)
    Rails.logger.debug "\nWriting a cookie with redirect path: '#{path}'\n" if path.present?
    store_location_for(:user, path) if path.present?
  end


  # @returns a relative URL to redirect to from passed query param
  # (for links to pages beyond login wall from emails, for example)
  #
  # https://skyfits.ru/my/sign_in/?next=https://kazino.ru    ->  nil
  # https://skyfits.ru/my/sign_in/?next=https://skyfits.ru   ->  nil
  # https://skyfits.ru/my/sign_in/?next=/my/orders/1/edit -> "/my/orders/1/edit"
  # https://skyfits.ru/my/sign_in/?next=my/orders/1/edit  -> "/my/orders/1/edit"
  # https://skyfits.ru/my/sign_in/?next=                     ->  nil
  # https://skyfits.ru/my/sign_in/                           ->  nil
  #
  def redirect_path_from_URL_params(request)
    uri = URI.parse(request.query_parameters["next"].presence) rescue nil
    return unless uri
    return unless uri.relative?
    path = uri.to_s
    return path if path.starts_with?("/")
    return "/" + path
  end

end
