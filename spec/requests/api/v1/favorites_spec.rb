equire 'rails_helper'

RSpec.describe "Favorite request", type: :request do
  describe "POST /api/v1/favorites" do
    describe "successful login request" do
      it "creates a favorite recipe for a user" do
        post "/api/v1/favorites", 
          params: {
            api_key: "a user in the database's api key",
            country: "thailand",
            recipe_link: "a link from thailand recipe response",
            recipe_title: " a title of a recipe from thailad recipe response"
          }.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body, symbolize_names: true)
          # require 'pry'; binding.pry
        expect(json_response).to have_key(:success)
        expect(json_response[:success]).to eq("Favorite added successfully")
      end
    end
  end
end