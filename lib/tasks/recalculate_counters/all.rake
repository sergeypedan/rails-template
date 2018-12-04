# frozen_string_literal: true

require "recalculate_counters_task"

namespace :recalculate_counters do
  task all: :environment do

    folder = 'recalculate_counters'

    Rake::Task["#{folder}:city_networks"].invoke
    # Rake::Task["#{folder}:city_plugs"].invoke # not ready yet
    Rake::Task["#{folder}:city_stations"].invoke

    Rake::Task["#{folder}:network_reviews"].invoke
    Rake::Task["#{folder}:network_stations"].invoke

    Rake::Task["#{folder}:station_plugs"].invoke
    Rake::Task["#{folder}:station_reviews"].invoke
  end
end
