class PlacesService

  def self.points_of_interest(country_name, city_name)
    coordinates = geocode_city(country_name, city_name)
    return unless coordinates
    
    # url = '/v1/geocode/search'
    url = '/v2/places'
    params = {
      categories: categories,
      conditions: conditions,
      filter: "circle:#{coordinates[:lon]},#{coordinates[:lat]},5000", # 5 km radius
      bias: "proximity:#{coordinates[:lon]},#{coordinates[:lat]}",
      limit: limit,
      apiKey: Rails.application.credentials.GEOAPIFY[:API_KEY]
      # text: "#{country_name}, #{city_name}",
      # format: 'json',
      # type: 'amenity',
      # bias: "proximity:#{coordinates[:lon]},#{coordinates[:lat]}",
      # limit: 10 
  }.compact

    response = call_api(url, params)
    parse_response(response)
  end

  private

  def self.geocode_city(country_name, city_name)
    endpoint = '/v1/geocode/search'
    params = {
      text: "#{city_name}, #{country_name}",
      format: 'json'
    }

    response = call_api(endpoint, params)
    coordinates = response[:features]&.first&.dig(:geometry, :coordinates)
    return { lat: coordinates[1], lon: coordinates[0] } if coordinates

    nil
  end

  def self.call_api(url, params = {})
    response = connection.get do |request|
      request.params = params
      request.params[:apiKey] = Rails.application.credentials.GEOAPIFY[:API_KEY]
      # req.headers['Content-Type'] = 'application/json'
      # req.headers['Accept-Language'] = 'en'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.geoapify.com')
  end

  def self.parse_response(response)
    response[:features]
  end
end