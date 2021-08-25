class AddUsernameTextFollowersIdToBookmarkedArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarked_articles, :username, :string
    add_column :bookmarked_articles, :text, :string
    add_column :bookmarked_articles, :followers, :integer
    add_column :bookmarked_articles, :tweet_id, :integer
  end
end
