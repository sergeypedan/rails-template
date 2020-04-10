namespace :yaml_to_db do

	task all_astrology: :environment do

		desc "Seeds all standard astrological objects"

		Rake::Task["yaml_to_db:nakshatras"].invoke
		Rake::Task["yaml_to_db:nakshatra:genders"].invoke
		Rake::Task["yaml_to_db:tithi"].invoke
		Rake::Task["yaml_to_db:planet_signs"].invoke
		Rake::Task["yaml_to_db:planets"].invoke
		Rake::Task["yaml_to_db:zodiacs_signs"].invoke
	end

end
