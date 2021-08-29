class FavoriteTopicsController < ApplicationController
  def index
    # @favorite_topics = FavoriteTopic.all
    @favorite_topics = current_user.favorite_topics

    @favorite_topics_tweets = {}
    @favorite_topics.each do |favorite_topic|
      @favorite_topics_tweets[favorite_topic.topic.title] = HandleTweets.new(favorite_topic.topic, 5).format_tweets
    end
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @favorite_topic = FavoriteTopic.new
    @favorite_topic.topic = @topic
    @favorite_topic.user = current_user

    if @favorite_topic.save
      redirect_to @topic
    else
      render 'topic/show'
    end
  end

  def destroy
    @favorite_topic = FavoriteTopic.find(params[:id])
    @favorite_topic.destroy

    redirect_to favorite_topics_path
  end
end
