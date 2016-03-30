require 'oauth'
consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'],
															 ENV['TWITTER_SECRET'],
															 { site: 'https://twitter.com'} )

puts "consumer: #{consumer}"
# here, consumer = application
request_token = consumer.get_request_token
token = request_token.token
secret = request_token.secret
url = request_token.authorize_url

puts "request_token: #{token}, secret: #{secret}, url: #{url}"

new_request_token = OAuth::RequestToken.new(consumer, token, secret)
access_token = new_request_token.get_access_token

puts access_token
