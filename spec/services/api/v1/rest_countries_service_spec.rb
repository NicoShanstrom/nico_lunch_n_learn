require 'rails_helper'

RSpec.describe RestCountriesService, type: :service do
  describe '.random_country' do
    describe 'when the API call is successful' do
      it 'returns a random country name' do
        VCR.use_cassette("random_country") do
          response = RestCountriesService.random_country
          
          expect(response).to be_a(String)
          expect(response).not_to be_empty
        end
      end
    end
    
    describe 'when the API call fails due to connection failure' do
      before do
        allow(RestCountriesService).to receive(:all_countries).and_raise(Faraday::ConnectionFailed.new("execution expired"))
      end

      it 'returns a random country name from the local COUNTRIES list' do
        response = RestCountriesService.random_country
        
        expect(response).to be_a(String)
        expect(response).to be_in(COUNTRIES)
      end
    end

    describe 'when the API call fails due to timeout' do
      before do
        allow(RestCountriesService).to receive(:all_countries).and_raise(Faraday::TimeoutError.new("execution expired"))
      end

      it 'returns a random country name from the local COUNTRIES list' do
        response = RestCountriesService.random_country
        
        expect(response).to be_a(String)
        expect(response).to be_in(COUNTRIES)
      end
    end
  end

  describe '.all_countries' do
    it 'returns a list of all country names' do
      VCR.use_cassette("all_countries") do
        response = RestCountriesService.all_countries
        
        expect(response).to be_an(Array)
        expect(response).not_to be_empty
        expect(response.first).to be_a(Country)
        expect(response.first.name).to be_a(String)
      end
    end
  end
end
