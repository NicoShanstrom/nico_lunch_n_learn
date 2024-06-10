require 'rails_helper'

RSpec.describe 'TouristSites API', type: :request do
  describe 'GET /api/v1/tourist_sites', :vcr do
    describe 'with a valid country parameter' do
      it 'returns tourist sites' do
        get '/api/v1/tourist_sites', params: { country: 'France' }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to be_a(Hash)
        expect(json_response[:data]).to be_an(Array)
        expect(json_response[:data].size).to eq(10)

        tourist_site = json_response[:data].first
        expect(tourist_site).to have_key(:id)
        expect(tourist_site).to have_key(:type)
        expect(tourist_site).to have_key(:attributes)
        expect(tourist_site[:attributes]).to have_key(:name)
        expect(tourist_site[:attributes]).to have_key(:address)
        expect(tourist_site[:attributes]).to have_key(:place_id)
      end
    end

    describe 'without a country parameter' do
      it 'returns an error' do
        get '/api/v1/tourist_sites'
        # require 'pry'; binding.pry
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to eq('Country parameter is required for search')
      end
    end
  end
end
