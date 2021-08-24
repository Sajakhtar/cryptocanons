class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @topics = Topic.all
    redirect_to topic_path(params[:search][:topic_id]) if params[:search]
  end
end
