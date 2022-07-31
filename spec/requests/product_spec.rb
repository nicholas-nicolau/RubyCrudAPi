require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "testing Health of application" do
    it "returns http success" do
      get "/products", headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(200)
    end

    it 'should validate empty header' do
      get '/products'
      expect(response).to have_http_status(406)
    end
  end

  def CreateProduct
    #creating category and measure to test product
    post "/categories", :params =>{"category":{"name":"categoryTeste"}}, headers: {'Accept' => 'multipart/form-data'}
    post "/measures", :params =>{"measure":{"name":"measureTeste"}}, headers: {'Accept' => 'multipart/form-data'}
    #creating a product
    post "/products", :params => {
      "product":{
        "name":"rspec_test",
        "category_id":"1",
        "measure_id":"1",
        "stock":1,
        "value":100,
        "highlight":true,
        "details":"detalhes",
      }
    }, headers: {'Accept' => 'multipart/form-data'}
  end

  describe "Testing Products' actions" do
    it "it creates a product" do
      self.CreateProduct
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['name']).to eq("rspec_test")
    end

    it "it edits a product" do
      self.CreateProduct
      json = JSON.parse(response.body)
      
      #editing product
      patch '/products/' + json['data']['id'].to_s, :params => {
        "product":{
          "name":"rspec_test_2",
          "category_id":"1",
          "measure_id":"1",
          "stock":1,
          "value":100,
          "highlight":true,
          "details":"detalhes",
        }
        }, headers: {'Accept' => 'multipart/form-data'}
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['name']).to eq("rspec_test_2")
    end

    it "it deletes a product" do
      self.CreateProduct
      json = JSON.parse(response.body)
      delete '/products/' + json['data']['id'].to_s, headers: {'Accept' => 'application/json'}
      expect(response).to have_http_status(204)
    end
  end
  
  describe "testing Products' validations" do
    it 'should validate empty fields' do
      #creating category and measure to test product
      post "/categories", :params =>{"category":{"name":"categoryTeste"}}, headers: {'Accept' => 'multipart/form-data'}
      post "/measures", :params =>{"measure":{"name":"measureTeste"}}, headers: {'Accept' => 'multipart/form-data'}
      #creating a product
      post "/products", :params => {
        "product":{
          "name":"",
          "category_id":"1",
          "measure_id":"1",
          "stock":"",
          "value":"",
          "highlight":"",
          "details":"",
        }
      }, headers: {'Accept' => 'multipart/form-data'}
      json = JSON.parse(response.body)
      expect(json).to eq(
        {
          "name"=>["can't be blank"],
          "stock"=>["can't be blank"],
          "value"=>["can't be blank"],
          "highlight"=>["can't be blank"],
          "details"=>["can't be blank"]
       }
      )
    end    
  end
end
