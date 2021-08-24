class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @topics = Topic.all

    # if the form is submitted, redirect
    if params[:search]
      redirect_to topic_path(params[:search][:topic_id])
    else
      render 'pages/home'
    end
  end
end
