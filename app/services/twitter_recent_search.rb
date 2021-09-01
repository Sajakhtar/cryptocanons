class TwitterRecentSearch
  def initialize(topic)
    @topic = topic
  end

  def fetch_tweets
    query = build_query
    query_params = get_query_params(query)
    options = create_options(query_params)
    recent_search(options)
  end

  private

  def build_query
    if @topic[:title] == "Cardano"
      'from:CardanoStiftung OR from:Cardano OR from:cardano_updates OR from:cardano_whale OR from:_CardanoReport OR CardanoDan OR from:Cardians_ OR from:ArdanaProject OR from:CardStarter OR from:CardanoSwap'
    else
      keyword = "\"#{@topic[:title]}\""
      keyword = "(\"#{@topic[:title]}\" OR \"#{@topic[:cashtag]}\")" if @topic[:cashtag]
      "#{keyword} lang:en is:verified"
    end
  end

  def get_query_params(query)
    {
      "query": query, # Required
      "max_results": 100,
      "start_time": Date.today.strftime("%Y-%m-%dT%H:%M:%SZ"),
      # "end_time": "2020-07-02T18:00:00Z",
      "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
      "tweet.fields": "attachments,author_id,conversation_id,created_at,entities,id,lang,public_metrics,source,text,context_annotations,possibly_sensitive,withheld,geo,referenced_tweets",
      "user.fields": "name,location,description,public_metrics,url,username,verified,withheld,protected,profile_image_url",
      # "media.fields": "url"
      # "place.fields": "country_code",
      # "poll.fields": "options"
    }
  end

  def create_options(query_params)
    {
      method: 'get',
      headers: {
        'User-Agent': "v2RecentSearchRuby",
        'Authorization': "Bearer #{ENV['BEARER_TOKEN']}"
      },
      params: query_params
    }
  end

  def recent_search(options)
    url = "https://api.twitter.com/2/tweets/search/recent"

    request = Typhoeus::Request.new(url, options)
    response = request.run

    JSON.parse(response.body)
  end
end
