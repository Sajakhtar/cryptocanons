# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'json'
# require 'open-uri'
# require 'rest-client'

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
topic_titles = ['Blockchain', 'Cryptocurrencies', 'Crypto', 'NFT', 'DeFi', 'Metaverse', 'Central Bank digital currency']

generic_icon = 'https://image.flaticon.com/icons/png/32/3985/3985588.png'

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
    sleep 1
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
