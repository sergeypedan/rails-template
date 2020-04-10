# frozen_string_literal: true

namespace :yaml_to_db do

	task week_days: :environment do

		count = WeekDay.count
		puts "\nCurrently we have #{count} week_days in DB"

		fail StandardError, "Not enought planets in DB" unless Planet.count >= Planet::COUNT

		if count.positive?
			puts "Deleting all existing week_days..."
			WeekDay.all.delete_all
			puts "Deleted", "\n"
		end

		puts "Starting to seed week_days"

		yaml_file = Rails.root.join("lib", "astrology", "db", "week_days.yml")
		contents  = YAML.load(yaml_file.read)

		contents.each do |record|

			day = WeekDay.create!(
				number:      record["number"],
				name:        record["name"],
				description: record["description"],
				planet_id:   Planet.find_by(name_russian: record["planet"]).id
			)

			puts "Created #{day.name}"

		end

		puts "Done!"
		puts "Currently we have #{WeekDay.count} week_days in DB"

	end

end
