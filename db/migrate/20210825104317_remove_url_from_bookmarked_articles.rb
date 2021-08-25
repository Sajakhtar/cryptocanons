class RemoveUrlFromBookmarkedArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookmarked_articles, :url
  end
end
