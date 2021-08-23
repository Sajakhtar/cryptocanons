class FavoriteTopicsController < ApplicationController
  def index
    @favorite_topic = FavoriteTopic.all
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

end
