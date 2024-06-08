class EdamamService
  
  def self.recipe_search(country_name)
    url = '/api/recipes/v2'
    params = {
      type: 'public',
      q: country_name
    }

    response = call_api(url, params)
    # parse_response(response)
    response
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:app_id] = Rails.application.credentials.EDAMAM[:API_ID]
      request.params[:app_key] = Rails.application.credentials.EDAMAM[:APP_KEY]
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept-Language'] = 'en'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.edamam.com')
  end

end