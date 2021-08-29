json.array!(@topic_tweets) do |tweet|
  json.tweet json.partial!('shared/tweet_partial.html.erb', tweet: tweet)
end

# json.array! @topic_tweets

# json.tweet do
#   json.partial! 'shared/tweet_partial.html.erb', locals: { tweet: @topic_tweets[0]}
# end


# json.tweets json.partial!('shared/hello_world.html.erb')
