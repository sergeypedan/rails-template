# frozen_string_literal: false

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('../.ruby-version', __FILE__)).chomp

gem "active_storage_validations"
gem "activeadmin"
gem "activeadmin_addons"
# gem "activerecord-sortable"
# gem "activeadmin_sortable_table"
# gem "acts_as_list"
gem "asset_bom_removal-rails"
gem "autoprefixer-rails"
# gem "aws-sdk"
# gem "babel-transpiler"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap" # v4
gem "bootstrap", ">= 5"
gem "burner_email_db"
# gem "carrierwave"
# gem "coffee-rails"
gem "devise"
gem "dry-schema"
gem "dry-validation"
gem "enumerize"
# gem "execjs", platforms: :ruby
gem "figaro"
gem "font-awesome-rails"
# gem "google-webfonts-rails"
# gem "haml"
gem "image_processing"
gem "image_magick"
gem "integral-corrector",   github: "sergeypedan/integral-corrector"
gem "jbuilder"
gem "jquery-rails" # github: "rails/jquery-rails"
# gem "jquery-turbolinks"
gem "jquery-ui-rails"
gem "kaminari"
gem "kramdown"
gem "localer"
gem "meta-tags"
# gem "mysql2", ">= 0.4.4", "< 0.6.0"
# gem "nokogiri"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-vkontakte"
# gem "paperclip"
gem "pg", ">= 0.18", "< 2.0" # must appear before [puma, rails, russian]
gem "puma"
# gem "rack-timeout"
gem "rails"
gem "random_record"
gem "redis"
# gem "rmagick"
# gem "russian"
gem "sassc-rails" # github: "rails/sass-rails", branch: "master"
gem "sidekiq"
gem "sinatra"
gem "slim-rails", github: "slim-template/slim-rails"
gem "sprockets-rails"
# gem "susy"
# gem "tinymce-rails"
# gem "therubyracer", platforms: :ruby
# gem "turbolinks"
gem "uglifier"
# gem "unicode"
gem "webpacker"

group :development, :test do
	gem "bullet"
	gem "byebug", platform: :mri
	gem "database_consistency", require: false
	# gem "dotenv-rails"
	gem "factory_bot_rails" # must be also in dev for generators
	gem "faker" # must be also in dev for generators
	gem "letter_opener"
	gem "listen", ">= 3.0.5", "< 3.2"
	gem "pry-rails"
	gem "pry-byebug"
	# gem "spring"
	# gem "spring-watcher-listen", "~> 2.0.0"
	# gem "sqlite3"
end

group :development do
	gem "annotate"
	gem "better_errors"
	gem "binding_of_caller"
	gem "bundler-audit"
	gem "capistrano", require: false
	gem "capistrano-chruby"
	gem "capistrano-nvm", require: false
	gem "capistrano-rails", require: false
	gem "capistrano-rotatelog"
	gem "capistrano-systemd-multiservice", require: false
	# gem "capistrano3-puma"
	gem "faker" # must be also in dev for generators
	gem "listen", ">= 3.0.5", "< 3.2"
	# gem "meta_request" # stack too deep error on Rails 6.1.3
	# gem "rails-erd" #rake erd
	gem "rails_real_favicon"
	# gem "web-console"
end

group :test do
	gem "capybara"
	gem "factory_trace"
	# gem "chromedriver-helper"
	gem "rspec-rails"
	gem "selenium-webdriver"
	gem "webmock"
	gem "wisper-rspec", require: false
end

group :production do
	# gem "rails_12factor" # no need anymore
end
