class HandleTweets
  def initialize(topic, number_of_tweets)
    @topic = topic
    @number_of_tweets = number_of_tweets
  end

  def format_tweets
    api_result = TwitterRecentSearch.new(@topic).fetch_tweets
    tweets = api_result['data']
    users = api_result['includes']['users']
    tweets_data = top_tweets(tweets, users)
    tweets_data = tweets_data.sort_by {|tweet| tweet['user']["public_metrics"]["followers_count"] }.reverse
    tweets_data.first(@number_of_tweets)
  end

  private

  def top_tweets(tweets, users)
    tweets.map! do |tweet|
      author = users.find { |user| user['id'] == tweet['author_id'] }
      tweet['user'] = author

      if tweet['user']["public_metrics"]["followers_count"] > 1000
        tweet['tweet_url'] = "https://twitter.com/#{tweet['user']['username']}/status/#{tweet['id']}"
      else
        tweets.delete(tweet)
      end
      tweet
    end
  end
end
