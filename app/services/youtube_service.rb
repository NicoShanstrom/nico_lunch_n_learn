class YoutubeService
  def self.search(query_keywords)
    url = 'search'
    params = {
      part: "snippet",
      maxResults: 1,
      q: query_keywords,
      channelId: "UCluQ5yInbeAkkeCndNnUhpw"
    }

    response = call_api(url, params)
    parse_response(response)
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:key] = Rails.application.credentials.YOUTUBE[:API_KEY]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://www.googleapis.com/youtube/v3')
  end

  def self.parse_response(response)
    item = response[:items]&.first
    if item
      {
        title: item[:snippet][:title],
        youtube_video_id: item[:id][:videoId]
      }
    else
      {}
    end
  end
end