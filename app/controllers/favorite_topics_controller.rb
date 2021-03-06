class FavoriteTopicsController < ApplicationController
  def index
    # @favorite_topics = FavoriteTopic.all
    @favorite_topics = current_user.favorite_topics
    @topics = Topic.all
    @favorite_topics = @favorite_topics.map do |favorite_topic|
      bookmark_size = current_user.bookmarked_articles.where(topic: favorite_topic.topic).size
      [favorite_topic, bookmark_size]
    end
    # @favorite_topic = current_user.favorite_topics.find(params[:favorite_topic])

    # @favorite_topics_tweets = {}
    # @favorite_topics.each do |favorite_topic|
    #   @favorite_topics_tweets[favorite_topic.topic.title] = HandleTweets.new(favorite_topic.topic, 5).format_tweets
    # end
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @favorite_topic = FavoriteTopic.new
    @favorite_topic.topic = @topic
    @favorite_topic.user = current_user

    if @favorite_topic.save
      flash[:alert] = "#{@topic.title} has been added to your Favorite Topics"
      redirect_to topic_path(@topic)
    else
      render 'topic/show'
    end
  end

  def destroy
    @favorite_topic = FavoriteTopic.find(params[:id])
    @favorite_topic.destroy

    redirect_to favorite_topics_path
  end

  def tweets
    @topic = Topic.find(params[:topic_id])
    topic = { title: params[:title], cashtag: params[:cashtag] }
    @topic_tweets = HandleTweets.new(topic, 5).format_tweets
    @coingecko_id = params[:coingecko_id]
    @bookmarks = current_user.bookmarked_articles.where(topic: @topic)
    @favorite_topic_to_delete = current_user.favorite_topics.where(topic: @topic).first
    # p @topic_tweets
    # p @coingecko_id

    respond_to do |format|
      format.json
    end
  end
end
