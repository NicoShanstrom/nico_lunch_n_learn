class RestCountriesService
  
  def self.country_search(country_name)
    url = "/name/#{country_name}"

    response = call_api(url)
    # parse_response(response)
    response
  end
  
  def self.random_country
    COUNTRIES.sample
  end
  
  private

  def self.call_api(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://restcountries.com/v3.1')
  end
end