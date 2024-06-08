class Api::V1::RecipesController < ApplicationController
  def index
    country_name = params[:country]

    if country_name.blank?
      country_name = RestCountriesService.random_country
    end

    recipes = EdamamService.recipe_search(country_name)
    formatted_recipes = format_recipes(recipes, country_name)
    render json: RecipeSerializer.new(formatted_recipes).serializable_hash
    # require 'pry'; binding.pry
  end

  private
  
  def format_recipes(recipes, country_name)
    recipes[:hits].map do |hit|
      Recipe.new(
        title: hit[:recipe][:label],
        url: hit[:recipe][:url],
        country: country_name,
        image: hit[:recipe][:image]
      )
    end
  end
end