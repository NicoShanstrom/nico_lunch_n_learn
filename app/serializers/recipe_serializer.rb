class RecipeSerializer
  include JSONAPI::Serializer
  
  set_type :recipe
  set_id { nil }

  attributes :title, :url, :country, :image
end