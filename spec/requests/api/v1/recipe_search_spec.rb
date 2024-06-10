require 'rails_helper'

RSpec.describe "Recipes API", type: :request do
  describe "GET /api/v1/recipes" do
    describe "when country parameter is provided" do
      it 'returns recipes for the specified country', :vcr do
        country_name = 'thailand'
        get "/api/v1/recipes?country=#{country_name}"

        expect(response).to have_http_status(:success)
        # require 'pry'; binding.pry
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:data)
        expect(json_response[:data]).to be_an(Array)

        recipe = json_response[:data].first
        expect(recipe[:id]).to be_nil
        expect(recipe[:type]).to eq('recipe')
        expect(recipe[:attributes]).to have_key(:title)
        expect(recipe[:attributes]).to have_key(:url)
        expect(recipe[:attributes]).to have_key(:country)
        expect(recipe[:attributes]).to have_key(:image)
        expect(recipe[:attributes]).to_not have_key(:images)
        expect(recipe[:attributes]).to_not have_key(:source)
        expect(recipe[:attributes]).to_not have_key(:dietLabels)
      end
    end

    describe "when country parameter is not provided" do
      it 'returns recipes for a random country', :vcr do
        allow(RestCountriesService).to receive(:random_country).and_return('India')
        get "/api/v1/recipes"

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:data)
        expect(json_response[:data]).to be_an(Array)
        recipe = json_response[:data].first
        
        expect(recipe[:id]).to be_nil
        expect(recipe[:type]).to eq('recipe')
        expect(recipe[:attributes]).to have_key(:title)
        expect(recipe[:attributes]).to have_key(:url)
        expect(recipe[:attributes]).to have_key(:country)
        expect(recipe[:attributes]).to have_key(:image)
      end
    end

    describe "when country parameter returns no recipes" do
      it 'returns an empty array', :vcr do
        country_name = 'countrywithnorecipes'
        get "/api/v1/recipes?country=#{country_name}"

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:data]).to eq([])
      end
    end
  end
end
