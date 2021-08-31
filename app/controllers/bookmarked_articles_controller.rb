class BookmarkedArticlesController < ApplicationController
  def index
    @bookmarked_articles = BookmarkedArticle.all
    # @bookmarked_article = BookmarkedArticle.find(params[:id])

  end

  def show
    @bookmarked_article = BookmarkedArticle.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmarked_article = BookmarkedArticle.new(strong_params)
    @bookmarked_article.user = current_user
    @bookmarked_article.topic = @topic
    @bookmarked_article.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @bookmarked_article = BookmarkedArticle.find(params[:id])
    @bookmarked_article.destroy

    redirect_to bookmarked_articles_path
  end

  private

  def strong_params
    params.require(:bookmarked_article).permit(:username, :text, :tweet_id, :followers)
  end
end
