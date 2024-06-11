class RestCountriesService
  
  def self.country_search(country_name)
    url = "/v3.1/name/#{country_name}"

    response = call_api(url)
    response.first[:name][:common]
    # parse_response(response)
  end
  
  def self.random_country
    # COUNTRIES.sample
    countries = all_countries
    countries.sample
  end
  
  private

  def self.call_api(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://restcountries.com')
  end

  def self.all_countries
    url = "/v3.1/all"
    response = call_api(url)
    response.map { |country| country[:name][:common] }
  end
end