# frozen_string_literal: true

desc "Checks unused DB tables & columns"
# from http://blog.ianenders.com/coding/2013/07/02/detecting-unused-db-fields-in-rails.html

namespace :check do
  namespace :db do
    task unused: :environment do
      # require_relative './config/environment.rb'

      connection = ActiveRecord::Base.connection

      connection.tables.collect do |table|
        count = connection.select_all("SELECT count(1) as count FROM #{table}", "Count").first['count']

        puts "TABLE UNUSED #{table}" if count.to_i == 0

        columns = connection.columns(table).collect(&:name).reject {|x| x == 'id' }
        columns.each do |column|
          values = connection.select_all("SELECT DISTINCT('#{column}') AS val FROM #{table} LIMIT 2", "Distinct Check")
          if values.count == 1
            if values.first['val'].nil?
              puts "COLUMN UNUSED #{table}:#{column}"
            else
              puts "COLUMN SINGLE VALUE #{table}:#{column} -- #{values.first['val']}"
            end
          end
        end

      end
    end
  end
end
