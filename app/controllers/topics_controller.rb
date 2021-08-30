class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    # if params[search] take params[:search][:id]
    #else take params[:id]
    @topic = Topic.find(params[:id])
    @topics = Topic.all
    raise
    @tweets_data = HandleTweets.new(@topic, 5).format_tweets
    @is_favorite = !FavoriteTopic.where(topic: @topic, user: current_user).empty?
  end
end
