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

puts "Creating users ..."

users = [
  { first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: '123456' },
  { first_name: 'Jane', last_name: 'Doe', email: 'jane@gmail.com', password: '123456' },
  { first_name: 'Jon', last_name: 'Snow', email: 'jon@gmail.com', password: '123456' },
  { first_name: 'Jack', last_name: 'Jones', email: 'jack@gmail.com', password: '123456' }
  # {first_name: 'Joe', last_name: 'Blogs', email: 'joe@gmail.com', password: '123456'},
  # {first_name: 'David', last_name: 'Smith', email: 'david@gmail.com', password: '123456'},
  # {first_name: 'Jenny', last_name: 'Smith', email: 'jenny@gmail.com', password: '123456'},
  # {first_name: 'Jamey', last_name: 'Johnson', email: 'jamey@gmail.com', password: '123456'}
]

users.each do |attributes|
  User.create!(attributes)
end

puts "Finished creating users!"


puts "Creating topic titles..."

Topic.create(title: "bitcoin")
Topic.create(title: "ethereum")
Topic.create(title: "nft")
Topic.create(title: "defi")

puts "Finished creating topics!"
