# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

# set :application, Rails.application.credentials.domain # sergeypedan.ru
set :application, "sergeypedan.ru"

# set :repo_url, Rails.application.credentials.dig(:code, :repo, :url)
set :repo_url, "git@gitlab.com:sergey_pedan/sergeypedan.ru.git"

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

set :migration_role, :app

set :chruby_ruby, "2.6.5"

# Defaults to [:web]
set :assets_roles, [:web, :app]

set :puma_daemonize, true
set :puma_init_active_record, true
set :puma_preload_app, true
set :puma_threads, [1, 4]
set :puma_workers, 0

# Defaults to "assets"
# This should match config.assets.prefix in your rails config/application.rb
# set :assets_prefix, "prepackaged-assets"

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you’d like to clean up old assets after each deploy,
# set this to the number of versions to keep
set :keep_assets, 2

# Defaults to ["/path/to/release_path/public/#{fetch(:assets_prefix)}/.sprockets-manifest*", "/path/to/release_path/public/#{fetch(:assets_prefix)}/manifest*.*"]
# This should match config.assets.manifest in your rails config/application.rb
# set :assets_manifests, ["app/assets/config/manifest.js"]

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/sergeypedan.ru
# set :deploy_to, "/var/www/sergeypedan.ru"

# Default value for :format is :airbrussh.
set :format, :airbrussh
# set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/master.key"
                    # , "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs,  ".bundle",
                      "log",
                      "node_modules",
                      "public/code-samples",
                      "public/cv",
                      "public/system",
                      "public/uploads",
                      "storage",
                      "tmp/cache",
                      "tmp/log",
                      "tmp/pids",
                      "tmp/sockets",
                      "vendor/bundle"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV["USER"]
# set :local_user, -> { `git config user.name`.chomp }
set :local_user, "root"
# set :use_sudo, false
# set :user, "example"

# Default value for keep_releases is 5
set :keep_releases, 2

# Name for shared directory, containing files and directories symlinked into the release directory during deployment.
# set :shared_directory, "shared"

# Name for releases directory, target location for releases
# set :releases_directory, "releases"

# Name for current link pointing to the newest successful deployment’s release folder
# set :current_directory, "current"

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  # before :starting do
  #   within fetc(:deploy_to) do
  #     execute :gem, :install, :bundler
  #   end
  # end

  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! "config/master.key", "#{shared_path}/config/master.key"
        end
      end
    end
  end

end

after "deploy:restart", "deploy:cleanup"
