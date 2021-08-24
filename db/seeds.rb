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

key = ENV["COINMARKETCAP_KEY"]
url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=#{key}&limit=200"


response = RestClient.get url
results = JSON.parse(response)

data = results['data']

topic_titles = ['blockchain', 'cryptocurrencies', 'crypto', 'nft', 'nonfungible tokens', 'defi', 'decentralized finance', 'cefi', 'centralized finance', 'metaverse', 'cdbc', 'central bank digital currency', 'stable coin', 'yield farming', 'liquidity mining']

data.map! do |crypto|
  "#{crypto['name']} $#{crypto['symbol']}"
end

topic_titles += data

topic_titles.each do |topic|
  Topic.create!(title: topic)
end

puts "Finished creating topics!"

puts "Creating BookmarkedArticle..."

BookmarkedArticle.create!(user: User.first, url: "www.google.com")
BookmarkedArticle.create!(user: User.second, url: "www.google.com")
BookmarkedArticle.create!(user: User.third, url: "www.google.com")
BookmarkedArticle.create!(user: User.fourth, url: "www.google.com")

puts "Finished BookmarkedArticle!"

puts "Creating FavoriteTopics..."

FavoriteTopic.create!(user: User.first, topic: Topic.first)
FavoriteTopic.create!(user: User.second, topic: Topic.second)
FavoriteTopic.create!(user: User.third, topic: Topic.third)
FavoriteTopic.create!(user: User.fourth, topic: Topic.fourth)

puts "Finished FavoriteTopics..."
