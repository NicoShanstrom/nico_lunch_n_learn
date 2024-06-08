class RestCountriesService
  
  def self.country_search(country_name)
    url = 'name'
    params = {q: country_name}

    response = call_api(url, params)
    # parse_response(response)
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      # req.headers['Content-Type'] = 'application/json'
  end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://restcountries.com')
  end

end