class BookmarkedArticlesController < ApplicationController
  def index
    @bookmarked_articles = BookmarkedArticle.all
  end

  def show
    @bookmarked_article = BookmarkedArticle.find(params[:id])
  end

  def create
    @bookmarked_article = BookmarkedArticle.new(strong_params)
    @bookmarked_article.user = current_user
    if @bookmarked_article.save
      redirect_to @bookmarked_article

    else
      render root_path
    end
  end

  private

  def strong_params
    params.require(:tweet).permit(:username, :text, :tweet_id, :followers)
  end
end
