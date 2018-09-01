# Gems

gem "nokogiri"

gem_group :development, :test do
	gem "rspec-rails"
end



# Custom functions

def setup__database
	rails_command "db:create"
	rails_command "db:migrate"
	rake "db:migrate", env: "test"
end

def setup__git_repo
	git :init
	git add: "-A"
	git commit: %Q{ -m 'Initial commit' }
end

def setup__heroku
	heroku create __app_name__
end

def setup__annotator
end

def setup__domain
	# If options[:env] is specified, the line is appended to the corresponding file in config/environments
	# otherwise will be added to config/application.rb
	environment 'config.action_mailer.default_url_options = { host: "localhost:3000" }', env: :development
	environment 'config.action_mailer.default_url_options = { host: "localhost:3000" }', env: :test
	environment 'config.action_mailer.default_url_options = { host: "http://domain.com" }', env: :production
end

def setup__homepage
	generate :controller, "Home show"
	route "root to: 'home#index'"
end

def setup__rspec
	rails generate rspec:install
end

def setup__user
	generate :scaffold, "user", "first_name:string", "last_name:string", "uuid:string", "facebook_id:string", "vkontakte_id:string"
end

def setup__vuejs
	rails_command "webpacker:install:vue"
end

def setup__webpacker
	rails_command "webpacker:install"
end



# Bundling

bundle install

after_bundle do
	setup__database
	setup__rspec
	setup__annotator
	setup__webpacker
	setup__vuejs
	setup__domain
	setup__git_repo
	setup__heroku
	setup__homepage
	setup__user
end


initializer 'bloatlol.rb', <<-CODE
	mycode
CODE

# Similarly, lib() creates a file in the lib/ directory and vendor() creates a file in the vendor/ directory.


#ask(question)
lib_name = ask("What do you want to call the shiny library ?")
lib_name << ".rb" unless lib_name.index(".rb")

lib lib_name, <<-CODE
	class Shiny
	end
CODE
