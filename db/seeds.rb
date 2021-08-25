# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'rest-client'

puts "cleaning DB"
User.destroy_all
Topic.destroy_all
FavoriteTopic.destroy_all
BookmarkedArticle.destroy_all

puts "Creating users ..."

users_attributes = [
  { first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: '123456' },
  { first_name: 'Jane', last_name: 'Doe', email: 'jane@gmail.com', password: '123456' },
  { first_name: 'Jon', last_name: 'Snow', email: 'jon@gmail.com', password: '123456' },
  { first_name: 'Jack', last_name: 'Jones', email: 'jack@gmail.com', password: '123456' }
  # {first_name: 'Joe', last_name: 'Blogs', email: 'joe@gmail.com', password: '123456'},
  # {first_name: 'David', last_name: 'Smith', email: 'david@gmail.com', password: '123456'},
  # {first_name: 'Jenny', last_name: 'Smith', email: 'jenny@gmail.com', password: '123456'},
  # {first_name: 'Jamey', last_name: 'Johnson', email: 'jamey@gmail.com', password: '123456'}
]

User.create!(users_attributes)

puts "Finished creating users!"

puts "Creating topic titles..."

# General Topics
topic_titles = ['blockchain', 'cryptocurrencies', 'crypto', 'nft', 'defi', 'metaverse', 'central bank digital currency']

generic_icon = 'https://image0.flaticon.com/icons/png/128/2152/2152488.png'

topic_titles.each do |topic|
  Topic.create!(title: topic, icon_url: generic_icon)
end

# Coin Topics
coingecko_response = RestClient.get 'https://api.coingecko.com/api/v3/coins/list'
coingecko_results = JSON.parse(coingecko_response)


key = ENV["COINMARKETCAP_KEY"]
coinmarketcap_url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"

coinmarketcap_response = RestClient.get coinmarketcap_url
coinmarketcap_results = JSON.parse(coinmarketcap_response)
data = coinmarketcap_results['data']


data.map! do |crypto|
  crypto["cashtag"] = "$#{crypto['symbol']}"

  coingecko_coin_data = coingecko_results.find { |coin| coin["symbol"].downcase == crypto["symbol"].downcase }
  crypto["coingecko_id"] = coingecko_coin_data['id'] if coingecko_coin_data

  if crypto["coingecko_id"]
    # Coingecko Free API* has a rate limit of 50 calls/minute
    sleep 0.5
    coinggecko_coin_endpoint = "https://api.coingecko.com/api/v3/coins/#{crypto["coingecko_id"]}"
    coingecko_coin_response = RestClient.get coinggecko_coin_endpoint
    coingecko_coin_results = JSON.parse(coingecko_coin_response)

    if coingecko_coin_results["image"]["thumb"]
      crypto["coingecko_icon_url"] = coingecko_coin_results["image"]["thumb"]
    end
  else
    crypto["coingecko_icon_url"] = generic_icon
  end

  crypto
end

data.each do |topic|
  Topic.create!(title: topic['name'], symbol: topic['symbol'], cashtag: topic['cashtag'], icon_url: topic['coingecko_icon_url'], coingecko_id: topic['coingecko_id'])
end


puts "Finished creating topics!"

puts "Creating BookmarkedArticle..."

BookmarkedArticle.create!(user: User.first, url: "https://twitter.com/Cointelegraph/status/1430358523360288768")
BookmarkedArticle.create!(user: User.second, url: "https://twitter.com/JordanSchachtel/status/1430198722122686473")
BookmarkedArticle.create!(user: User.third, url: "https://twitter.com/Okcoin/status/1430207419473448972")
BookmarkedArticle.create!(user: User.fourth, url: "https://twitter.com/BTCTN/status/1430350295528259588")

puts "Finished BookmarkedArticle!"

puts "Creating FavoriteTopics..."

FavoriteTopic.create!(user: User.first, topic: Topic.first)
FavoriteTopic.create!(user: User.second, topic: Topic.second)
FavoriteTopic.create!(user: User.third, topic: Topic.third)
FavoriteTopic.create!(user: User.fourth, topic: Topic.fourth)

puts "Finished FavoriteTopics..."
