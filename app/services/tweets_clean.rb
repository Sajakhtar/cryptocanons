class TweetsClean
  def initialize(topic, number_of_tweets)
    @topic = topic
    @number_of_tweets = number_of_tweets
  end

  def tweets
    tweets_service = TweetsRaw.new(@topic)
    api_result = tweets_service.fetch_tweets

    @tweets_data = api_result['data']
    @tweets_users = api_result['includes']['users']
    @tweets_data.map! do |tweet|
      author = @tweets_users.find { |user| user['id'] == tweet['author_id'] }
      tweet['user'] = author
      # if tweet's user has more than 1K followers then do ******
      # tweet.delete(:author_id)
        tweet['tweet_url'] = "https://twitter.com/#{tweet['user']['username']}/status/#{tweet['id']}"
        tweet
      # else
        # remove tweet from array ******* @tweets_data.delete(tweet)
    end
    @tweets_data.select! { |tweet| tweet['user']["public_metrics"]["followers_count"] > 1000  }

    @tweets_data = @tweets_data.sort_by {|tweet| tweet['user']["public_metrics"]["followers_count"] }.reverse

    @tweets_data = @tweets_data.first(@number_of_tweets)
  end

end
