# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

Rake.add_rakelib "lib/tasks/recalculate_counters"
Rake.add_rakelib "lib/tasks/yaml_to_db"
