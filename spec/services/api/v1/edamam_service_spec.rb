require 'rails_helper'

RSpec.describe EdamamService, type: :service do
  describe '.recipe_search', :vcr do
    it 'can find recipes for a specific country' do
      country_name = 'thailand'
      response = EdamamService.recipe_search(country_name)
      
      expect(response).to be_an(Array)
      expect(response.first).to be_a(Recipe)
      expect(response.first.title).to be_present
      expect(response.first.url).to be_present
      expect(response.first.country).to eq(country_name)
      expect(response.first.image).to be_present
    end

    it 'returns an empty array if no recipes are found' do
      country_name = 'nonexistentcountry'
      response = EdamamService.recipe_search(country_name)

      expect(response).to be_empty
    end
  end
end
