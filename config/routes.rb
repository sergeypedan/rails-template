Rails.application.routes.draw do

  root to: "pages#home"

  resources :articles, only: [:index, :show]

  get "/about",          to: "pages#about"
  get "/terms",          to: "pages#terms"
  get "/privacy_policy", to: "pages#privacy_policy"


  get "admin", to: "admin#index"

  namespace :admin do
    resources :articles
  end

  match ":url", to: "errors#not_found", via: :all, constraints: { url: /.*/ }

end
