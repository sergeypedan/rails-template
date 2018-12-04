namespace :yaml_to_db do

	task planets: :environment do

		planets_count = ::Planet.count
		puts "Currently we have #{planets_count} planets in DB"

		if planets_count > 0
			puts "Deleting all existing planets..."
			Planet.all.delete_all
			puts "Deleted", "\n"
		end

		puts "Starting to seed planets"

		yaml_file = Rails.root.join("lib", "astrology", "db", "planets.yml")
		contents  = YAML.load(yaml_file.read)

		contents.each_with_index do |planet_object, index|

			name_english = planet_object["name_english"]
			puts "#{name_english}"

			Planet.create(
				name_english:  planet_object["english_name"],
				name_russian:  planet_object["russian_name"],
				name_sanskrit: planet_object["sanskrit_name"]
			)

		end

		puts "Done!"
		puts "Currently we have #{Planet.count} planets in DB"

	end

end
