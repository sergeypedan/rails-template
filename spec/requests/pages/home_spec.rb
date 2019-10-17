# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :request do

  context "Not logged in" do
    it "has status :ok" do
      get root_path
      expect(response).to have_http_status :ok
    end
  end

end
