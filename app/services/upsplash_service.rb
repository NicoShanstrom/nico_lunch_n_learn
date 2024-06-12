class UpsplashService

  def self.photo_search(country_name)
    url = '/search/photos'
    params = { query: country_name }
    response = call_api(url, params)
    parse_response(response)
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:client_id] = Rails.application.credentials.UPSPLASH[:ACCESS_KEY]
      request.headers['Accept-Version'] = 'v1'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://api.unsplash.com')
  end

  def self.parse_response(response)
    response[:results].map do |image|
      {
        alt_tag: image[:alt_description],
        url: image[:urls][:regular]
      }
    end
  end
end