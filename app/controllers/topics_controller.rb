class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @topic = Topic.find(params[:id])

    # raise
    @tweets_data = HandleTweets.new(@topic, 5).format_tweets
    @is_favorite = !FavoriteTopic.where(topic: @topic, user: current_user).empty?
  end

  def search
    @topic = Topic.find(params[:search][:topic])
    # raise
    redirect_to @topic
  end
end
