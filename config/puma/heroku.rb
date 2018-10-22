# Example: https://github.com/puma/puma/blob/master/examples/config.rb

environment ENV.fetch("RACK_ENV") { "development" }

port ENV.fetch("PORT") { 3000 }

preload_app!

rackup DefaultRackup

threads 1, Integer(ENV.fetch("MAX_THREADS") { 2 })
# Min and Max threads per worker

workers Integer(ENV.fetch("WEB_CONCURRENCY") { 1 })
# Change to match your CPU core count

# on_worker_boot do
#   ActiveRecord::Base.establish_connection
# end
