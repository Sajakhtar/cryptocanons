class CreateFavoriteTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_topics do |t|
      t.references :user
      t.references :topic

      t.timestamps
    end
  end
end
