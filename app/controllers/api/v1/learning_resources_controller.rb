class Api::V1::LearningResourcesController < ApplicationController
  def index
    country_name = params[:country]

    if country_name.blank?
      render json: { error: 'Country parameter is required' }, status: :bad_request and return
    end

    video = YoutubeService.search(country_name)
    images = UpsplashService.photo_search(country_name)
    
    learning_resource = LearningResource.new(country_name, video || {}, images || [])
    render json: LearningResourceSerializer.new(learning_resource).serializable_hash
  end
end
