class FavoriteSerializer
  include JSONAPI::Serializer
  set_id :null
  set_type :favorite
  
  attributes :country, :recipe_link, :recipe_title, :user_id
end