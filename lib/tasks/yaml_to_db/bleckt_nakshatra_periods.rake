desc "Imports Bleckt data"

namespace :yaml_to_db do
	task bleckt_nakshatra_periods: :environment do

		fail StandardErrror, "Nakshatra records must exist" unless Nakshatra.count == Nakshatra::COUNT

		def get_nakshatra_data(day_data)
			Astrology::Bleckt::NakshatraPeriodParser.new(day_data).parse
		end

		def year_file_data_records(year)
			Astrology::Bleckt::YearLoader.load(year: year)
		end


		count = NakshatraPeriod.count

		puts "Now have #{count} nakshatra periods in DB"

		if count.positive?
			puts "Purging existing records"
			NakshatraPeriod.delete_all
		end

		Astrology::Bleckt::YearLoader::AVAILABLE_YEARS.each do |year|

			puts "\nStarting to create records for year #{year}"

			year_file_data_records(year).each do |date, data_hash|
				data = get_nakshatra_data(data_hash)

				puts "Creating period for #{date}"

				NakshatraPeriod.create!(
					number: data[:number],
					from:   data[:from],
					till:   data[:till],
					nakshatra_id: Nakshatra.find_by(number: data[:number]).id
				)
			end
		end

		puts "Now have #{NakshatraPeriod.count} nakshatra periods in DB"

	end
end
