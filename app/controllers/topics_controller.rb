class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    if params[:search]
      @topic = Topic.find(params[:search][:topic])
    else
      @topic = Topic.find(params[:id])
    end

    @topics = Topic.all
    # raise
    @tweets_data = HandleTweets.new(@topic, 5).format_tweets
    @is_favorite = !FavoriteTopic.where(topic: @topic, user: current_user).empty?
  end
end
