require 'rails_helper'

RSpec.describe "Favorite request", type: :request do
  describe "POST /api/v1/favorites" do
    let(:user) { 
      User.create(
        name: "Nico", email: "test@example.com", 
        password: "password", password_confirmation: "password"
      ) 
    }
    describe "successful login request" do
      it "creates a favorite recipe for a user" do
        post "/api/v1/favorites", 
          params: {
            api_key: user.api_key,
            country: "thailand",
            recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_889856aa0bd54dd1bb5a09d29546e60a",
            recipe_title: "YumYum"
          }.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:success)
        expect(json_response[:success]).to eq("Favorite added successfully")
      end
    end

    describe "unsuccessful request" do
      it "returns an error when API key is invalid" do
        post "/api/v1/favorites", 
          params: {
            api_key: "invalidapikey",
            country: "Nigeria",
            recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_889856aa0bd54dd1bb5a09d29546e60a",
            recipe_title: "DoDo, Nigerian plantains"
          }.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:error]).to eq("Invalid API key")
      end
    end
  end
end