class YoutubeService
  def self.search(query_keywords)
    url = 'search'
    params = {
      part: 'snippet',
      maxResults: 1,
      videoEmbeddable: true,
      q: query_keywords,
      channel_id: UCluQ5yInbeAkkeCndNnUhpw
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

    if response.key?(:error)
      error_message = response[:error][:message]
      raise StandardError, "YouTube API error: #{error_message}"
    else
      items = response[:items] || []
      items.map do |item|
        YoutubeVideo.new(
          id: { videoId: item[:id][:videoId] },
          snippet: item[:snippet],
          title: item[:snippet][:title],
          url: "https://www.youtube.com/watch?v=#{item[:id][:videoId]}",
        )
      end
    end
  end
end