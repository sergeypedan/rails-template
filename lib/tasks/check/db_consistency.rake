# frozen_string_literal: true

desc "Checks DB consistency"
# https://github.com/djezzzl/database_consistency

namespace :check do
  namespace :db do
    task consistency: :environment do
      # require_relative './config/environment.rb'
      Rails.application.eager_load!

      # Now start the check
      require 'database_consistency'
      result = DatabaseConsistency.run
      exit result

    end
  end
end
