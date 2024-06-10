# app/serializers/tourist_site_serializer.rb
class TouristSiteSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :tourist_site
  attributes :name, :address, :place_id

  attribute :name do |object|
    object[:name]
  end

  attribute :address do |object|
    object[:address]
  end

  attribute :place_id do |object|
    object[:place_id]
  end
end
