# frozen_string_literal: true

# https://stackoverflow.com/questions/7744171/how-to-test-a-custom-validator

require 'ostruct'

RSpec.describe UrlValidator, '#validate_each' do

  let(:err_obj) {
    OpenStruct.new do
      def read_attribute_for_validation(attr)
        self.public_send(attr)
      end
    end
  }
  let(:errors) { ActiveModel::Errors.new(err_obj) }
  let(:record) { instance_double(ActiveModel::Validations, errors: errors) }
  let(:attr_name) { :url }

  shared_examples "says valid" do
    it do
      expect { subject.validate_each(record, attr_name, test_value) }.to_not change(errors, :count)
    end
  end

  shared_examples "says invalid" do
    it do
      expect { subject.validate_each(record, attr_name, test_value) }.to change(errors, :count)
    end

    it do
      expect { subject.validate_each(record, attr_name, test_value) }.to change { errors.first }.to [attr_name, :invalid_format]
    end
  end

  context "no options" do
    subject { described_class.new(attributes: {}) }

    context "given a HTTP URL" do
      let(:test_value) { "http://ya.ru" }
      it_behaves_like "says valid"
    end

    context "given a HTTPs URL" do
      let(:test_value) { "https://ya.ru" }
      it_behaves_like "says valid"
    end

    context "given not an URL" do
      let(:test_value) { "ya.ru" }
      it_behaves_like "says invalid"
    end
  end

  context "{ only: :http }" do
    subject { described_class.new(attributes: { only: :http }) }

    context "given a HTTP URL" do
      let(:test_value) { "http://ya.ru" }
      it_behaves_like "says valid"
    end

    context "given a HTTPs URL" do
      let(:test_value) { "https://ya.ru" }
      it_behaves_like "says invalid"
    end

    context "given not an URL" do
      let(:test_value) { "ya.ru" }
      it_behaves_like "says invalid"
    end
  end

  context "{ only: :https }" do
    subject { described_class.new(attributes: { only: :https }) }

    context "given a HTTP URL" do
      let(:test_value) { "http://ya.ru" }
      it_behaves_like "says invalid"
    end

    context "given a HTTPs URL" do
      let(:test_value) { "https://ya.ru" }
      it_behaves_like "says valid"
    end

    context "given not an URL" do
      let(:test_value) { "ya.ru" }
      it_behaves_like "says invalid"
    end
  end

end
