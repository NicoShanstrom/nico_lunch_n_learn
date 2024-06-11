require 'rails_helper'

RSpec.describe "Favorite request", type: :request do
  let(:user) { 
    User.create(
      name: "Nico", email: "test@example.com", 
      password: "password", password_confirmation: "password"
    ) 
  }

  let(:user2) { 
    User.create(
      name: "Wolf", email: "test1@example.com", 
      password: "password1", password_confirmation: "password1"
    ) 
  }

  before do
    user.favorites.create(
      country: "thailand",
      recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_889856aa0bd54dd1bb5a09d29546e60a",
      recipe_title: "YumYum"
    )
    user.favorites.create(
      country: "egypt",
      recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
      recipe_title: "Recipe: Egyptian Tomato Soup"
    )
  end

  describe "POST /api/v1/favorites" do
    describe "successful post favorite request" do
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

  describe "GET /api/v1/favorites" do
    describe "successful get request for a user's favorites" do
      it "returns a users favorite recipes" do
        get "/api/v1/favorites?api_key=#{user.api_key}",
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to be_a(Hash)
        expect(json_response[:data]).to be_an(Array)

        favorite = json_response[:data].first
        expect(favorite).to have_key(:id)
        expect(favorite[:id]).to be_a(String)

        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq("favorite")

        expect(favorite).to have_key(:attributes)
        expect(favorite[:attributes]).to be_a(Hash)
        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes][:country]).to be_a(String)
        expect(favorite[:attributes]).to have_key(:created_at)
      end
    end

    describe "unsuccessful request" do
      it "returns an error when API key is invalid" do
        get "/api/v1/favorites?api_key=newenglandclamchowder", 
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }

        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:error]).to eq("Invalid API key")
      end
    end

    describe "no favorites" do
      it "returns an empty array when user has no favorites" do
        get "/api/v1/favorites?api_key=#{user2.api_key}", 
            headers: {
              "Content-Type" => "application/json",
              "Accept" => "application/json"
            }
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to be_a(Hash)
        expect(json_response[:data]).to be_an(Array)
        expect(json_response[:data]).to be_empty
      end
    end
  end
end