class UpsplashService

  def self.photo_search(country_name)
     url = '/search/photos'
    params = { query: country_name }
    response = call_api(url, params)
    response
    # require 'pry'; binding.pry
  end
  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:client_id] = Rails.application.credentials.UPSPLASH[:ACCESS_KEY]
      request.headers['Accept-Version'] = 'v1'
      # require 'pry'; binding.pry
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.unsplash.com')
  end
end