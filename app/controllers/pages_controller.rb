class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @topics = Topic.all
    @blockchain_topic = Topic.find_by(title: 'Blockchain')
    @tweets_data = HandleTweets.new(@blockchain_topic, 3).format_tweets
    redirect_to topic_path(params[:search][:topic]) if params[:search]
  end
end
