class RestCountriesService
  
  def self.country_search(country_name)
    url = "/name/#{country_name}"

    response = call_api(url)
    response
    # parse_response(response)
  end
  
  def self.random_country
    # COUNTRIES.sample
    countries = all_countries
    countries.sample[:name][:common]
  end
  
  private

  def self.call_api(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://restcountries.com/v3.1')
  end

  def self.all_countries
    url = "/all"
    response = call_api(url)
    response
  end
end