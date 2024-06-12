class RestCountriesService
  
  def self.random_country
    begin
      countries = all_countries
      countries.sample.name
    rescue Faraday::ConnectionFailed, Faraday::TimeoutError
      COUNTRIES.sample
    end
  end
  
  private

  def self.all_countries
    url = "/v3.1/all"
    response = call_api(url)
    response.map { |country_data| Country.new(country_data) }
  end

  def self.call_api(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://restcountries.com')
  end

end