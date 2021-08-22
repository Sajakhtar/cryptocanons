class CreateBookmarkedArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarked_articles do |t|
      t.string :url
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
