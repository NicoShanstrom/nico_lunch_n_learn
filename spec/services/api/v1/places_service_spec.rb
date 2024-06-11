require 'rails_helper'

RSpec.describe PlacesService do
  describe '.tourist_sites', :vcr do
    describe 'with a valid country name' do
      it 'returns an array of TouristSite objects' do
        response = PlacesService.tourist_sites("France")

        expect(response).to be_an(Array)
        expect(response.size).to be <=10

        response.each do |tourist_site|
          expect(tourist_site).to be_a(TouristSite)
          expect(tourist_site.name).to be_present
          expect(tourist_site.address).to be_present
          expect(tourist_site.place_id).to be_present
        end
        
        expect(response.first.name).to eq("Abbaye de Noirlac")
        expect(response.first.address).to eq("Abbaye de Noirlac, Route de Noirlac, 18200 Bruère-Allichamps, France")
        expect(response.first.place_id).to eq("5143321358deb0034059d12104d6605f4740f00101f9017c9bf20000000000920311416262617965206465204e6f69726c6163")
      end
    end
  end
end