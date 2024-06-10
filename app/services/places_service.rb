class PlacesService

  def self.tourist_sites(country_name)
    coordinates = geocode_country(country_name)
    return [] unless coordinates
    
    # url = '/v1/geocode/search'
    url = '/v2/places'
    params = {
      categories: tourism,
      filter: "circle:#{coordinates[:lon]},#{coordinates[:lat]},50000", # 50 km radius
      limit: 10
    }

    response = call_api(url, params)
    parse_response(response)
  end

  private

  def self.geocode_country(country_name)
    url = '/v1/geocode/search'
    params = {
      text: country_name,
      format: 'json'
    }

    response = call_api(url, params)
    coordinates = response[:features]&.first&.dig(:geometry, :coordinates)
    return { lat: coordinates[1], lon: coordinates[0] } if coordinates

    nil
  end

  def self.call_api(url, params = {})
    response = connection.get do |request|
      request.params = params
      request.params[:apiKey] = Rails.application.credentials.GEOAPIFY[:API_KEY]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.geoapify.com')
  end

  def self.parse_response(response)
    {
      data: response[:features].map do |tourist_site|
        {
          id: nil,
          type: 'tourist_site',
          attributes: {
            name: site[:properties][:name],
            address: site[:properties][:formatted],
            place_id: site[:properties][:place_id]
          }
        }
      end
    }
  end
end