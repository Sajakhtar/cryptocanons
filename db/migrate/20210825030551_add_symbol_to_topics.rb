class AddSymbolToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :symbol, :string
    add_column :topics, :cashtag, :string
    add_column :topics, :icon_url, :string
    add_column :topics, :coingecko_id, :string
  end
end
