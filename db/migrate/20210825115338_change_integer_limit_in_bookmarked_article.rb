class ChangeIntegerLimitInBookmarkedArticle < ActiveRecord::Migration[6.1]
  def change
    change_column :bookmarked_articles, :tweet_id, :integer, limit: 8
  end
end
