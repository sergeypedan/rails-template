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


  devise_for :users, controllers: {
    confirmations:      "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations:      "users/registrations",
    sessions:           "users/sessions"
  }

  devise_scope :user do
    get  "/users/login",       to: "users/sessions#new"
    get  "/users/login",       to: "users/sessions#new",             as: :login_user
    get  "/users/login/email", to: "users/sessions#login_email",     as: :login_user_email
    post "/users/login/email", to: "users/sessions#create_by_email", as: :login_by_email_action
    get  "/users/recover",     to: "users/passwords#new",            as: :recover_user
    post "/users/recover",     to: "users/passwords#create",         as: :recover_user_action
    put  "/users/recover",     to: "users/passwords#update",         as: :recover_update_password_action
    get  "/users/register",    to: "users/users#new",                as: :new_user
    post "/users/register",    to: "users/users#register",           as: :register_user
    get  "/users/sign_out",    to: "users/sessions#destroy"

    namespace :user, path: "my" do
      root to: "orders#index"

      resource :user, path: "profile", only: [:show, :update, :edit]

      resources :orders, only: :index
      resources :bonus_entries, only: :index
      resources :reviews, only: [:index, :update, :edit]

      post "bonus_entries/check_all", to: "bonus_entries#check_all"
      get  "bonus_program_faq",       to: "bonus_entries#faq"
      get  "coupons",                 to: "coupons#show"
      post "coupons/activate",        to: "coupons#activate"
      get  "invite_friend",           to: "referrals#invite"

      get   "favorite_quests", to: "quests#favorite"
      match "favorite_quests", to: "quests#change_favorite", via: [:delete, :post]

      get   "visited_quests",  to: "quests#visited"
      match "visited_quests",  to: "quests#change_visited",  via: [:delete, :post]
    end
  end


  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint.new

  get "/feed", to: "feed#index", as: :feed, defaults: { format: :xml }

  match ":url", to: "errors#not_found", via: :all, constraints: { url: /.*/ }

end
