# frozen_string_literal: true

require "recalculate_counters_task"

master = "city"
slave  = "location"

namespace :recalculate_counters do
  desc "Rebuilds #{slave.pluralize} counter cache for #{master}"
  task "#{master}_#{slave.pluralize}".to_sym => :environment do
    RecalculateCountersTask.new(master, slave).run
  end
end
