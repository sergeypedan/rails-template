namespace :yaml_to_db do

	task tithi: :environment do

		tithi_count = Tithi.count
		puts "Currently we have #{tithi_count} in DB"

		if tithi_count > 0
			puts "Deleting all existing tithi..."
			Tithi.delete_all
			puts "Deleted"
		end

		puts "Starting to seed tithi"

		yaml_file = Rails.root.join("lib", "astrology", "db", "tithi.yml")
		records   = YAML.load(yaml_file.read)

		records.each_with_index do |record, index|
			new_tithi = Tithi.create(
				number:    (index + 1),
				russian_name:  record["russian_name"],
				sanskrit_name: record["sanskrit_name"],
				description:   record["description"]
			)
			puts "creating #{record['russian_name']}"
		end

		puts "Done!"
		puts "Currently we have #{Tithi.count} in DB"

	end

end
