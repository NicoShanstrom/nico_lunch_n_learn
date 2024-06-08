class PlacesService

  def self.points_of_interest(country_name)
    params = {categories: }

    response = call_api(url, params)
    # parse_response(response)
  end

  private

  def self.call_api(url, params = {})
    response = connection.get do |request|
      request.params = params
      request.params[:key] = Rails.application.credentials.GEOAPIFY[:API_KEY]
      # req.headers['Content-Type'] = 'application/json'
      # req.headers['Accept-Language'] = 'en'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.geoapify.com/v2/places')
  end

end