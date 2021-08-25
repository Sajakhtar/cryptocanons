# require 'date'
# require 'json'
# require 'typhoeus'

class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @topic = Topic.find(params[:id])
    api_result = twitter_recent_search
    @tweets_data = api_result['data']
    @tweets_users = api_result['includes']['users']
    @tweets_data.map! do |tweet|
      author = @tweets_users.find { |user| user['id'] == tweet['author_id'] }
      tweet['user'] = author
      # tweet.delete(:author_id)
      tweet['tweet_url'] = "https://twitter.com/#{tweet['user']['username']}/status/#{tweet['id']}"
      tweet
    end
    @tweets_data.select! { |tweet| tweet['user']["public_metrics"]["followers_count"] > 1000  }

    @tweets_data.sort! { |a,b| b['user']["public_metrics"]["followers_count"] <=> a['user']["public_metrics"]["followers_count"]}

    # https://twitter.com/#{tweet['user']['username']}/status/#{tweet['id']}

    @tweets_data = @tweets_data.first(5)
  end

  private

  def twitter_recent_search
    bearer_token = ENV["BEARER_TOKEN"]
    search_url = "https://api.twitter.com/2/tweets/search/recent"

    keyword = "\"#{@topic.title}\""
    keyword += "OR \"#{@topic.cashtag}\"" if @topic.cashtag
    query = "#{keyword} lang:en is:verified -is:quote -is:retweet -is:reply (has:media OR has:links OR has:hashtags OR has:videos OR has:mentions)"

    query_params = {
      "query": query, # Required
      "max_results": 100,
      # "start_time": "2021-08-24T00:00:00Z", # TRY WITH RUBY DATE
      "start_time": Date.today.strftime("%Y-%m-%dT%H:%M:%SZ"),
      # "end_time": "2020-07-02T18:00:00Z",
      "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
      "tweet.fields": "attachments,author_id,conversation_id,created_at,entities,id,lang,public_metrics,source,text,context_annotations,possibly_sensitive,withheld,geo,referenced_tweets",
      "user.fields": "name,location,description,public_metrics,url,username,verified,withheld,protected,profile_image_url",
      "media.fields": "url"
      # "place.fields": "country_code",
      # "poll.fields": "options"
    }

    def search_tweets(url, bearer_token, query_params)
      options = {
        method: 'get',
        headers: {
          "User-Agent": "v2RecentSearchRuby",
          "Authorization": "Bearer #{bearer_token}"
        },
        params: query_params
      }

      request = Typhoeus::Request.new(url, options)
      response = request.run

      return response
    end

    response = search_tweets(search_url, bearer_token, query_params)
    # puts response.code, JSON.pretty_generate(JSON.parse(response.body))
    result = JSON.parse(response.body)

    # puts response.code, JSON.pretty_generate(result['data'][0])
  end
end
