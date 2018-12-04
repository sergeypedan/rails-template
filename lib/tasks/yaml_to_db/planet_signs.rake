namespace :yaml_to_db do

	task planet_signs: :environment do

		# planet_signs_count = PlanetSign.all.count
		# puts "Currently we have #{planet_signs_count} in DB"

		# if planet_signs_count > 0
		# 	puts "Deleting all existing planet_signs..."
		# 	PlanetSign.all.delete_all
		# 	puts "Deleted", "\n"
		# end

		# puts "Starting to seed planet_signs"

		# yaml_file = Rails.root.join("lib", "astrology", "db", "planet_signs.yml")
		# yaml      = YAML.load(yaml_file.read)

		# yaml.each_with_index do |planet_object, index|

		# 	planet_name = planet_object["planet_name"]
		# 	signs       = planet_object["signs"]

		# 	signs.each_with_index do |sign_object, ind|

		# 		sign_number = ind + 1
		# 		puts "#{planet_name} in #{sign_object['sign_name_latin']} (#{sign_number}): #{sign_object["description_long"].truncate(20)}"

		# 		PlanetSign.create(
		# 			planet:            planet_name,
		# 			sign_number:       sign_number,
		# 			description_short: sign_object["description_long"],
		# 			description_long:  sign_object["description_long"]
		# 		)
		# 	end

		# end

		# puts "Done!"
		# puts "Currently we have #{PlanetSign.all.count} in DB"

	end

end
