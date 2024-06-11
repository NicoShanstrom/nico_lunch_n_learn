require 'rails_helper'

RSpec.describe RestCountriesService, type: :service do
  describe '.country_search' do
    it 'returns country data for a specific country' do
      VCR.use_cassette("country_search_thailand") do
        country_name = 'Thailand'
        response = RestCountriesService.country_search(country_name)
        expect(response).to be_a(String)
        expect(response).to eq("Thailand")
      end
    end
  end
  
  describe '.random_country' do
    it 'returns a random country name' do
      VCR.use_cassette("random_country") do
        response = RestCountriesService.random_country
        expect(response).to be_a(String)
        expect(response).not_to be_empty
      end
    end
  end
  
  describe '.all_countries' do
    it 'returns a list of all country names' do
      VCR.use_cassette("all_countries") do
        response = RestCountriesService.all_countries
        expect(response).to be_an(Array)
        expect(response).not_to be_empty
        expect(response.first).to be_a(String)
      end
    end
  end
end
