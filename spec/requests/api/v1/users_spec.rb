require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe "POST /api/v1/users" do
    describe "with valid parameters" do
      it "creates a new user and returns an API key" do
        post "/api/v1/users",
          params: {
              name: "Odell",
              email: "goodboy@ruffruff.com",
              password: "treats4lyf",
              password_confirmation: "treats4lyf"
          }.to_json,
          headers: { 
          "Content-Type" => "application/json",
          "Accept" => "applicationjson"
          }

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(respoonse.body, symbolize_names: true)
        expect(json_response[:data]).to have_key(:id)
        expect(json_response[:data][:attributes]).to include(
          name: "Odell",
          email: "googboy@ruffruff.com"
          api_key: anything
        )
      end
    end

    describe "with invalid parameters" do
      it "returns an error when email is not unique" do
        User.create(
          name: "Odell", 
          email: "goodboy@ruffruff.com", 
          password: "password", 
          password_confirmation: "password")

        post "/api/v1/users", 
          params: {
            name: "Odell",
            email: "goodboy@ruffruff.com",
            password: "treats4lyf",
            password_confirmation: "treats4lyf"
          }.to_json,
          headers: { 
            "Content-Type" => "application/json",
            "Accept" => "applicationjson"
          }
        
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to include("Email has already been taken")
      end

      it "returns an error when passwords do not match" do
        post "/api/v1/users", 
          params: {
            name: "Odell",
            email: "goodboy@ruffruff.com",
            password: "treats4lyf",
            password_confirmation: "treats4lyfe"
          }.to_json,
          headers: { 
            "Content-Type" => "application/json",
            "Accept" => "applicationjson"
          }
          
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to include("Password confirmation doesn't match Password")
      end
    end
  end
end