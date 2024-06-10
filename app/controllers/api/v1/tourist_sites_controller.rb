class Api::V1::TouristSitesController < ApplicationController
  
  def index
    country = params[:country]
    if country.present?
      tourist_sites = PlacesService.tourist_sites(country)
      render json: TouristSiteSerializer.new(tourist_sites).serializable_hash.to_json
    else
      render json: { error: "Country parameter is required for search" }, status: :bad_request
    end
  end
end