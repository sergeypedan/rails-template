web: bundle exec puma --config "config/puma/heroku.rb"
worker: bundle exec sidekiq --config "config/sidekiq.yml" --logfile "log/sidekiq.log" --queue mailers --concurrency 1
