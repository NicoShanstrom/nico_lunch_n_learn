require 'rails_helper'

RSpec.describe EdamamService, type: :service do
  describe '.recipe_search', :vcr do
    it 'can find recipes for a specific country' do
      country_name = 'thailand'
      response = EdamamService.recipe_search(country_name)
      # require 'pry'; binding.pry
      expect(response).to be_a(Hash)
      expect(response).to have_key(:hits)

      first_recipe = response[:hits].first[:recipe]
      expect(first_recipe).to have_key(:label)
      expect(first_recipe).to have_key(:url)
      expect(first_recipe).to have_key(:image)
    end

    it 'returns an empty array if no recipes are found' do
      country_name = 'nonexistentcountry'
      response = EdamamService.recipe_search(country_name)

      expect(response[:hits]).to be_empty
    end
  end
end
