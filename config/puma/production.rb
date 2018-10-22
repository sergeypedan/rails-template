# Example: https://github.com/puma/puma/blob/master/examples/config.rb

app_dir    = File.expand_path("../../..", __FILE__)
shared_dir = File.expand_path("../../../../shared", __FILE__)
db_config  = "#{app_dir}/config/database.yml"
log_dir    = "#{shared_dir}/log"
pid_dir    = "#{shared_dir}/pids"
socket_dir = "#{shared_dir}/sockets"

max_threads = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
min_threads = 1
rails_env   = ENV.fetch("RAILS_ENV") { "production" }

activate_control_app
bind "unix://#{socket_dir}/puma.sock"
daemonize true
environment rails_env
pidfile "#{pid_dir}/puma.pid"
plugin :tmp_restart
port ENV.fetch("PORT") { 3000 }
rackup "#{app_dir}/config.ru"
state_path "#{pid_dir}/puma.state"
stdout_redirect "#{log_dir}/puma.stdout.log", "#{log_dir}/puma.stderr.log", true
threads min_threads, max_threads
workers 1

on_worker_boot do
  require "active_record"
  db_params = YAML.load_file(db_config)[rails_env]
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection( db_params )
end
