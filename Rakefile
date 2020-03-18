# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# DB tasks
Rake.add_rakelib "lib/tasks/recalculate_counters"
Rake.add_rakelib "lib/tasks/yaml_to_db"

# localer gem
require 'localer'
require 'localer/rake_task'
Localer::RakeTask.new()

# bundle-audit gem
require 'bundler/audit/task'
Bundler::Audit::Task.new
