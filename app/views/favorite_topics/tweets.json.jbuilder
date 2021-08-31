json.chart json.partial!('shared/chart_card.html.erb',
  coingecko_id: @coingecko_id,
  bookmarks: @bookmarks,
  favorite_topic: @favorite_topic_to_delete
)


json.tweets do
  json.array!(@topic_tweets) do |tweet|
    json.tweet json.partial!('shared/tweet_partial.html.erb', tweet: tweet, topic: @topic)
  end
end
