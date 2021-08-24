tweets = [
	{ message: 'Hello world', user_id: 1 },
	{ message: 'Olá Mundo', user_id: 2 },
	{ message: 'Hey! I know how to do this', user_id: 1 }
]
users = [
	{ id: 1, name: 'Khamza' },
	{ id: 2, name: 'Andre' }
]
# If we have lots of tweets,
# but we'll only display a few, this is the best solution
# option number one - find the user as we go (not my favorite)
tweets.each do |tweet|
  author = users.find { |user| user[:id] == tweet[:user_id] }
	puts "#{tweet[:message]} by #{author[:name]}"
end
# this would be the best if we have many tweets
# AND we will display most (if not all) of them
#option number two
# map the array tweets
tweets_with_users = tweets.map do |tweet|
	author = users.find { |user| user[:id] == tweet[:user_id] }
	tweet[:user] = author
	tweet.delete(:user_id)
	tweet
end
p tweets_with_users
