class AddReferencesToBookmarkedArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookmarked_articles, :topic, null: false, foreign_key: true
  end
end
