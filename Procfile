web: bundle exec puma --config "config/puma.rb" --daemon
web: bundle exec bin/rails server -p $PORT -e $RAILS_ENV

worker: bundle exec rake jobs:work

sidekiq: bundle exec sidekiq -e production -C config/sidekiq.yml -q mailers

redis: redis-server config/redis.conf
