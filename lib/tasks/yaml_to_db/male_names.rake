namespace :yaml_to_db do
	task male_names: :environment do
		desc "Transfers male names from YAML file to DB"
		HumanNamesLoader.new(:male).call
	end
end
