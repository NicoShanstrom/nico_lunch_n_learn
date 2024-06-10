class Api::V1::RecipesController < ApplicationController
  def index
    country_name = params[:country]

    if country_name.blank?
      country_name = RestCountriesService.random_country
    end

    recipes = EdamamService.recipe_search(country_name)
    # require 'pry'; binding.pry
    render json: RecipeSerializer.new(recipes).serializable_hash
  end
end