namespace :yaml_to_db do

	task zodiacs_signs: :environment do

		file = Rails.root.join("lib", "astrology", "db", "zodiac_signs.json").read
		json = JSON.parse(file)

		json.each_with_index do |sign, index|

			sign = json[index]

			ZodiacSign.create(
				number:           sign["number"].to_i,
				utf_symbol:       sign["utf_symbol"].to_i,
				russian_name:     sign["russian_name"],
				russian_name_rod: sign["russian_name_rod"],
				latin_name:       sign["latin_name"],
				latin_name_brief: sign["latin_name_brief"],
				nature_element:   sign["nature_element"],
				ruler:            sign["ruler"],
				exaltation:       sign["exaltation"],
				fall:             sign["fall"],
				detriment:        sign["detriment"]
			)
		end

	end

end
