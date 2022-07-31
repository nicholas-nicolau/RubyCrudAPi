require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "testing Health of application" do
    it "returns http success" do
      get "/categories", headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(200)
    end

    it 'should validate empty header' do
      get '/categories'
      expect(response).to have_http_status(406)
    end
  end

  def CreatesCategory
    post "/categories", :params => {"category":{"name":"rspec_test"}}, headers: {'Accept' => 'multipart/form-data'}
  end

  describe "Testing Categories' actions" do
    it "it creates a category" do
      self.CreatesCategory
      json = JSON.parse(response.body)
      expect(json['name']).to eq("rspec_test")
    end

    it "it edits a category" do
      self.CreatesCategory
      json = JSON.parse(response.body)
      patch '/categories/' + json['id'].to_s, :params => {"category":{"name":"rspec_test_2"}}, headers: {'Accept' => 'multipart/form-data'}
      json = JSON.parse(response.body)
      expect(json['name']).to eq("rspec_test_2")
    end

    it "it deletes a category" do
      self.CreatesCategory
      json = JSON.parse(response.body)
      delete '/categories/' + json['id'].to_s, headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(204)
    end
  end

  describe "testing Categories' validations" do
    it 'should validate empty category name' do
      post '/categories', :params => {"category":{"name":""}}, headers: {'Accept' => 'multipart/form-data'}
      expect(response).to have_http_status(422)
    end    
  end

end
