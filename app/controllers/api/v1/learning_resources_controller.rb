class Api::V1::LearningResourcesController < ApplicationController
  def index
    country_name = params[:country]

    if country_name.blank?
      render json: { error: 'Country parameter is required' }, status: :bad_request and return
    end

    video = YoutubeService.search(country_name)
    images = UpsplashService.photo_search(country_name)[:results].map do |image|
      {
        alt_tag: image[:alt_description],
        url: image[:urls][:regular]
      }
    end

    learning_resource = {
      id: nil,
      type: "learning_resource",
      attributes: {
        country: country_name,
        video: video || {},
        images: images || []
      }
    }

    render json: LearningResourceSerializer.new(learning_resource).serializable_hash
  end
end
