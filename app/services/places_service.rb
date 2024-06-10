class PlacesService

  def self.tourist_sites(country_name)
    coordinates = geocode_country(country_name)
    return [] unless coordinates
    
    search_tourist_sites(coordinates)
  end

  private

  def self.geocode_country(country_name)
    url = '/v1/geocode/search'
    params = {
      text: country_name,
      format: 'json'
    }

    response = call_api(url, params)
    coordinates = response[:results]&.first
    return { lat: coordinates[:lat], lon: coordinates[:lon] } if coordinates

    nil
  end

  def self.search_tourist_sites(coordinates)
    url = '/v2/places'
    params = {
      categories: 'tourism',
      filter: "circle:#{coordinates[:lon]},#{coordinates[:lat]},50000",
      limit: 10
    }

    response = call_api(url, params)
    response[:features].map do |site|
      TouristSite.new(
        name: site[:properties][:name],
        address: site[:properties][:formatted],
        place_id: site[:properties][:place_id]
      )
    end
  end

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:apiKey] = Rails.application.credentials.GEOAPIFY[:API_KEY]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.geoapify.com')
  end
end