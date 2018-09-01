module Redirect

  def redirect_path
    return get_and_clear_redirect_path    if cookies[:return_to].present?
    return get_and_clear_redirect_path    if session[:return_to].present?
    return request.env['omniauth.origin'] if request.env['omniauth.origin']
    return request.env["HTTP_REFERER"]    if request.env["HTTP_REFERER"].present?
    return root_url
  end

  def get_and_clear_redirect_path
    return_to = session[:return_to] || cookies[:return_to]
    session[:return_to] = nil
    cookies.delete :return_to
    return_to
  end

end
