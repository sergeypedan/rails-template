# frozen_string_literal: false

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"

# gem "activeadmin"
gem "activerecord-sortable"
gem "asset_bom_removal-rails"
gem "autoprefixer-rails"
# gem "aws-sdk"
# gem "babel-transpiler"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap" # v4
# gem "carrierwave"
# gem "coffee-rails"
gem "devise"
# gem "execjs", platforms: :ruby
gem "figaro"
gem "font-awesome-rails"
# gem "google-webfonts-rails"
# gem "haml"
gem "jbuilder"
gem "jquery-rails" # github: "rails/jquery-rails"
# gem "jquery-turbolinks"
gem "jquery-ui-rails"
gem "kaminari"
gem "kramdown"
gem "meta-tags"
# gem "mysql2", ">= 0.4.4", "< 0.6.0"
# gem "nokogiri"
gem "omniauth-facebook"
gem "omniauth-vkontakte"
gem "paperclip"
gem "pg", ">= 0.18", "< 2.0" # must appear before [puma, rails, russian]
gem "puma"
# gem "rack-timeout"
gem "rails"
gem "random_record"
gem "redis"
# gem "rmagick"
gem "image_processing"
gem "image_magick"
gem "russian"
gem "sassc-rails" # github: "rails/sass-rails", branch: "master"
gem "sidekiq"
gem "sinatra"
gem "slim-rails", github: "slim-template/slim-rails"
# gem "susy"
# gem "tinymce-rails"
# gem "therubyracer", platforms: :ruby
# gem "turbolinks"
gem "uglifier"
# gem "unicode"
# gem "webpacker"

group :development, :test do
  # gem "active_record-annotate"
  gem "bullet"
  gem "byebug", platform: :mri
  # gem "dotenv-rails"
  gem "factory_bot_rails" # must be also in dev for generators
  gem "faker" # must be also in dev for generators
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "pry-rails"
  gem "pry-byebug"
  # gem "records_count"
  # gem "spring"
  # gem "spring-watcher-listen", "~> 2.0.0"
  # gem "sqlite3"
end

group :development do
  # gem "active_record-annotate"
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "listen", ">= 3.0.5", "< 3.2"
  # gem "rails-erd" #rake erd
  gem "rails_real_favicon"
  gem "web-console"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "chromedriver-helper"
  gem "rspec-rails"
  gem "selenium-webdriver"
end

group :production do
  # gem "rails_12factor" # no need anymore
end
