class LearningResourceSerializer
  include JSONAPI::Serializer

  set_id { nil }
  
  attributes :country, :video, :images

  attribute :video do |object|
    object[:attributes][:video]
  end

  attribute :images do |object|
    object[:attributes][:images]
  end
end