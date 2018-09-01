require "rails_helper"

RSpec.describe RatingHelper do

  describe "rating_stars_html" do

    subject { rating_stars_counts(mark) }

    context "for rating of 1" do
      let(:mark) { 1 }
      it "returns proper HTML" do
        expect(subject[:full_star]).to  eq 1
        expect(subject[:half_star]).to  eq 0
        expect(subject[:empty_star]).to eq 4
      end
    end

    context "for rating of 5" do
      let(:mark) { 5 }
      it "returns proper HTML" do
        expect(subject[:full_star]).to  eq 5
        expect(subject[:half_star]).to  eq 0
        expect(subject[:empty_star]).to eq 0
      end
    end

    context "for rating of 3,5" do
      let(:mark) { 2.1 }
      it "returns proper HTML" do
        expect(subject[:full_star]).to  eq 2
        expect(subject[:half_star]).to  eq 0
        expect(subject[:empty_star]).to eq 3
      end
    end

    context "for rating of 3,5" do
      let(:mark) { 3.5 }
      it "returns proper HTML" do
        expect(subject[:full_star]).to  eq 3
        expect(subject[:half_star]).to  eq 1
        expect(subject[:empty_star]).to eq 1
      end
    end

    context "for rating of 3,8" do
      let(:mark) { 3.8 }
      it "returns proper HTML" do
        expect(subject[:full_star]).to  eq 4
        expect(subject[:half_star]).to  eq 0
        expect(subject[:empty_star]).to eq 1
      end
    end

    context "for nil" do
      let(:mark) { nil }
      it { expect(subject).to be_nil }
    end

    context "for rating of 0" do
      let(:mark) { 0 }
      it { expect(subject).to be_nil }
    end

    context "for empty sting" do
      let(:mark) { "" }
      it { expect(subject).to be_nil }
    end

    context "for a sting" do
      let(:mark) { "five" }
      it "returns proper HTML" do
        expect { subject }.to raise_error ArgumentError
      end
    end

  end

end
