require "rails_helper"

RSpec.describe Product, "#destroy", type: :model do

	subject { product.destroy }

	let!(:product) { create :product }

	context "with no purchases" do
		it "can be deleted" do
			expect { subject }.to change(described_class, :count).from(1).to(0)
		end
	end

	context "with a purchase" do
		let!(:purchase) { create :purchase, product: product, user: user }
		let(:user) { create :user }

		it "cannot be deleted" do
			expect { subject }.not_to change(described_class, :count).from(1)
		end

		it do expect { subject }.not_to raise_exception end

		it "attaches an error to `product`" do
			subject
			errors = product.errors.where(:base)
			expect(errors).not_to be_empty
			expect(errors.first.type).to eq :"restrict_dependent_destroy.has_many"
		end
	end
end
