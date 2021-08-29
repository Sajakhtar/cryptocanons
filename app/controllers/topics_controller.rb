class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @topic = Topic.find(params[:id])
    @tweets_data = HandleTweets.new(@topic, 5).format_tweets
    @is_favorite = !FavoriteTopic.where(topic: @topic, user: current_user).empty?
  end
end
