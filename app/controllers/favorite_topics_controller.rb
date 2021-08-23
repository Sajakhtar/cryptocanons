class FavoriteTopicsController < ApplicationController
  def index
    @favorite_topics = FavoriteTopic.all
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
