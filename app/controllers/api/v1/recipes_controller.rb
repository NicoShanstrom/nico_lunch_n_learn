class Api::V1::RecipesController < ApplicationController
  def index
    country_name = params[:country]

    if country_name.blank?
      country_name = RestCountriesService.random_country
    end

    recipes = EdamamService.recipe_search(country_name)
    # formatted_recipes = format_recipes(recipes, country_name)
    # require 'pry'; binding.pry
    render json: RecipeSerializer.new(recipes).serializable_hash
  
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