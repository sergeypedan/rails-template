namespace :yaml_to_db do

	task karanas: :environment do

		karanas_count = Karana.count
		puts "Currently we have #{karanas_count} in DB"

		if karanas_count.positive?
			puts "Deleting all existing karanas..."
			Karana.delete_all
			puts "Deleted"
		end

		puts "Starting to seed karanas"

		yaml_file = Rails.root.join("lib", "astrology", "db", "karanas.yml")
		records   = YAML.load(yaml_file.read)

		records.each do |record|
			new_karana = Karana.create!(
				number:        record["number"],
				russian_name:  record["russian_name"],
				sanskrit_name: record["sanskrit_name"]
			)
			puts "created #{new_karana.sanskrit_name}"
		end

		puts "Done!"
		puts "Currently we have #{Karana.count} in DB"

	end

end
