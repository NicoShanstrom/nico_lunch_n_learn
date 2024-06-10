class Recipe
  attr_reader :title, :url, :country, :image

  def initialize(title:, url:, country:, image:)
    @title = title
    @url = url
    @country = country
    @image = image
  end
end

