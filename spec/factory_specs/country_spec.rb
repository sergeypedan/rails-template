# frozen_string_literal: true

RSpec.describe Country, "factory" do

	let(:factory_name) { described_class.to_s.tableize.singularize.to_sym }

	context "build" do
		subject { build factory_name }
		it { is_expected.to be_valid }
	end

	context "create" do
		subject { create factory_name }
		it { is_expected.to be_valid }
	end

end
