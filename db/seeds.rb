# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "cleaning DB"
User.destroy_all
Topic.destroy_all
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

users = User.create!(users_attributes)

puts "Finished creating users!"

puts "Creating topic titles..."

topic_titles = %[ bitcoin ethereum nft defi]

topics = Topic.create!(title: topic_titles)

puts "Finished creating topics!"

puts "Creating BookmarkedArticle..."

BookmarkedArticle.create!(user: users[0], url: "www.google.com")
BookmarkedArticle.create!(user: users[1], url: "www.google.com")
BookmarkedArticle.create!(user: users[2], url: "www.google.com")
BookmarkedArticle.create!(user: users[3], url: "www.google.com")

puts "Finished BookmarkedArticle!"

puts "Creating FavoriteTopics..."

FavoriteTopics.create!(user: users[0], topic: topics[0])
FavoriteTopics.create!(user: users[1], topic: topics[1])
FavoriteTopics.create!(user: users[2], topic: topics[2])
FavoriteTopics.create!(user: users[3], topic: topics[3])

puts "Finished FavoriteTopics..."
