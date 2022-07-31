require 'rails_helper'

RSpec.describe "Measures", type: :request do
  describe "testing Health of application" do
    it "returns http success" do
      get "/measures", headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(200)
    end

    it 'should validate empty header' do
      get '/measures'
      expect(response).to have_http_status(406)
    end
  end

  def CreatesMeasure
    post "/measures", :params => {"measure":{"name":"rspec_test"}}, headers: {'Accept' => 'multipart/form-data'}
  end
  describe "Testing Measures' actions" do
    it "it creates a measure" do
      self.CreatesMeasure
      json = JSON.parse(response.body)
      expect(json['name']).to eq("rspec_test")
    end

    it "it edits a measure" do
      self.CreatesMeasure
      json = JSON.parse(response.body)
      patch '/measures/' + json['id'].to_s, :params => {"measure":{"name":"rspec_test_2"}}, headers: {'Accept' => 'multipart/form-data'}
      json = JSON.parse(response.body)
      expect(json['name']).to eq("rspec_test_2")
    end

    it "it deletes a measure" do
      self.CreatesMeasure
      json = JSON.parse(response.body)
      delete '/measures/' + json['id'].to_s, headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(204)
    end
  end

  describe "testing Measures' validations" do
    it 'should validate empty measure name' do
      post '/measures', :params => {"measure":{"name":""}}, headers: {'Accept' => 'multipart/form-data'}
      expect(response).to have_http_status(422)
    end    
  end

end
