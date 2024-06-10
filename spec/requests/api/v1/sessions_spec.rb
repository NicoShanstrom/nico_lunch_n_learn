require 'rails_helper'

RSpec.describe "Login request", type: :request do
  describe "POST /api/v1/sessions" do
    describe "successful login request" do
      it "logs a user in" do
        post "/api/v1/sessions", 
          params: {
            email: "goodboy@ruffruff.com",
            password: "treats4lyf"
          }.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
          expect(response).to have_http_status(:success)
          json_response = JSON.parse(response.body, symbolize_names: true)
          # require 'pry'; binding.pry
        expect(json_response[:data]).to have_key(:id)
        expect(json_response[:data][:type]).to eq("user")
        expect(json_response[:data][:attributes]).to include(
          name: "Odell",
          email: "goodboy@ruffruff.com",
          api_key: anything
        )
      end
    end

    describe "unsucessful login request" do
      it "returns a 400-level status code and body with a description of why not sucessful" do
        post "/api/v1/sessions", 
          params: {
            email: "googboy@ruffruff.com",
            password: "treats4lyfe"
          }.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }

        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors][0]).to eq("Incorrect email and/or password")
      end
    end
  end
end