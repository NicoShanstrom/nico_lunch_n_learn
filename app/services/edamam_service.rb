class EdamamService
  
  def self.recipe_search(country_name)
    url = '/api/recipes/v2'
    params = {
      type: 'public',
      q: country_name
    }

    response = call_api(url, params)
    response
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:app_id] = Rails.application.credentials.EDAMAM[:APP_ID]
      request.params[:app_key] = Rails.application.credentials.EDAMAM[:APP_KEY]
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept-Language'] = 'en'
      # require 'pry'; binding.pry
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.edamam.com')
  end

end