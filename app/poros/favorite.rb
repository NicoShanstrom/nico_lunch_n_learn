class Favorite
  attr_reader :country, :recipe_link, :recipe_title, :user_id

  def initialize(attributes)
    @country = attributes[:country]
    @recipe_link = attributes[:recipe_link]
    @recipe_title = attributes[:recipe_title]
    @user_id = attributes[:user_id]
  end
end