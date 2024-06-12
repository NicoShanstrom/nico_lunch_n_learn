# spec/services/upsplash_service_spec.rb
require 'rails_helper'

RSpec.describe UpsplashService, type: :service do
  describe '.photo_search', :vcr do
    context 'when a valid country name is provided' do
      it 'returns a list of images' do
        response = UpsplashService.photo_search('laos')
        
        expect(response).to be_an(Array)

        response.each do |image|
          expect(image).to have_key(:alt_tag)
          expect(image).to have_key(:url)
        end
      end
    end

    context 'when an invalid country name is provided' do
      it 'returns an empty list' do
        response = UpsplashService.photo_search('invalidcountryname')

        expect(response).to eq([])
      end
    end
  end
end
