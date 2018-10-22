web: bin/rails server
worker: bundle exec sidekiq --config "config/sidekiq.yml" --logfile "log/sidekiq.log" --queue mailers --concurrency 1
