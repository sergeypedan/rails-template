desc "Imports Bleckt data"

namespace :yaml_to_db do
	task bleckt_karana_periods: :environment do

		fail StandardErrror, "Karana records must exist" unless Karana.count == Karana::COUNT

		def get_karana_data(day_data)
			Astrology::Bleckt::KaranaPeriodParser.new(day_data).parse
		end

		def year_file_data_records(year)
			Astrology::Bleckt::YearLoader.load(year: year)
		end


		count = KaranaPeriod.count

		puts "Now have #{count} karana periods in DB"

		if count.positive?
			puts "Purging existing records"
			KaranaPeriod.delete_all
		end

		Astrology::Bleckt::YearLoader::AVAILABLE_YEARS.each do |year|

			puts "\nStarting to create records for year #{year}"

			year_file_data_records(year).each do |date, data_hash|
				data = get_karana_data(data_hash)

				puts "Creating period for #{date}"

				KaranaPeriod.create!(
					number: data[:number],
					from:   data[:from],
					till:   data[:till],
					karana_id: Karana.find_by(number: data[:number]).id
				)
			end
		end

		puts "Now have #{KaranaPeriod.count} karana periods in DB"

	end
end
