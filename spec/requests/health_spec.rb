require 'rails_helper'

RSpec.describe "Healths", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/health/index",  headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(:success)
    end
  end

end
