namespace :yaml_to_db do

	task nakshatras: :environment do

		nakshatras_count = Nakshatra.count
		puts "Currently we have #{nakshatras_count} in DB"

		if nakshatras_count.positive?
			puts "Deleting all existing nakshatras..."
			Nakshatra.delete_all
			puts "Deleted"
		end

		puts "Starting to seed nakshatras"

		yaml_file = Rails.root.join("lib", "astrology", "db", "nakshatras.yml")
		records   = YAML.load(yaml_file.read)

		records.each do |record|
			new_nakshatra = Nakshatra.create!(
				number:        record["number"],
				russian_name:  record["russian_name"],
				sanskrit_name: record["sanskrit_name"],
				description:   record["description"],
				gender:        record["gender"],
				ruler:         record["ruler"]
			)
			puts "created #{new_nakshatra.sanskrit_name}"
		end

		puts "Done!"
		puts "Currently we have #{Nakshatra.count} in DB"

	end

end
