# frozen_string_literal: true

namespace :csv_to_db do

  task cities: :environment do
    desc 'Imports missing cities from CSV file to DB (does not override existing)'

    puts "Currently we have #{City.count} cities in DB"

    def reject_existing_records(incoming: [], existing: [], attribute_to_compare:)
      stop_words = existing.map(&attribute_to_compare)

      incoming.reject do |record|
        stop_words.include?( record[attribute_to_compare.to_s] )
      end
    end

    def csv_file_to_array_of_hashes(file_pathname)
      file_contents   = file_pathname.read
      parsing_options = { col_sep: ";", headers: :first_row }
      CSV.new(file_contents, parsing_options).map(&:to_h)
    end

    file_pathname = Rails.root.join("db", "csv", "cities.csv")
    new_records   = csv_file_to_array_of_hashes(file_pathname)
    puts "Imported a CSV file with #{new_records.size} records"

    filtered_records = reject_existing_records(incoming: new_records, existing: City.all, attribute_to_compare: :name)
    puts "Filtered out #{new_records.size - filtered_records.size} records, #{filtered_records.size} remain to import"

    puts

    filtered_records.each do |hash|
      puts "Importing #{hash['name']}"
      City.create!(
        position:     hash['sort'],
        name:         hash['name'],
        name_g:       hash['nameR'],
        name_p:       hash['nameP'],
        mk_subdomain: hash['url']
      )
    end

    puts "Finishes import with #{City.count} cities"
  end

end
