namespace :yaml_to_db do
	task female_names: :environment do
		desc "Transfers female names from YAML file to DB"
		HumanNamesLoader.new(:female).call
	end
end
