class Api::V1::TouristSitesController < ApplicationController
  def index
    country_name = params[:country_name]
    if country_name.present?
      tourist_sites = PlacesService.tourist_sites(country_name)
      render json: TouristSiteSerializer.new(tourist_sites).serializable_hash.to_json
      # render json: tourist_sites
    else
      render json: { error: "Country parameter is required for search" }
    end
  end
end