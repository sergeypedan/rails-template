Rails.application.routes.draw do

  root to: "pages#home"

  resources :articles, only: [:index, :show]

  get "/about",          to: "pages#about"
  get "/privacy_policy", to: "pages#privacy_policy"
  get "/sitemap",        to: "site_map#index", as: :site_map
  get "/terms",          to: "pages#terms"


  get "admin", to: "admin#index"

  namespace :admin do
    resources :articles
  end

  match ":url", to: "errors#not_found", via: :all, constraints: { url: /.*/ }

end
