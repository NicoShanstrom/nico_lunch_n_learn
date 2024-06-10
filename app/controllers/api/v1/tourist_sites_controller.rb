class Api::V1::TouristSitesController < ApplicationController
  def index
    if country.present?
      tourist_sites = PlacesService.tourist_sites(country)
      render json: tourist_sites
    else
      render json: { error: "Country parameter is required for search" }
  end
end