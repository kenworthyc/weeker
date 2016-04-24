require 'twitter'
require 'soundcloud'

get '/destinations/new' do
  erb :'destinations/new'
end

#Twitter Services

get '/twitter-authenticate' do
	get_twitter_info
end

get '/twitter-authentication-return' do
	get_twitter_access_token
	store_twitter_access_token
	redirect "/users/#{session[:user_id]}"
end

get '/test-tweet' do
	twitter_media_upload("This is something, I swear:", "https://dl.dropboxusercontent.com/s/ephkiagrqgfc0y4/IMG_8489.JPG?raw=1")
	redirect "/users/#{session[:user_id]}"
end

get '/test-soundcloud' do
  client = get_user
  p client
  redirect client.authorize_url()
end

get '/soundcloud-complete' do
  code = params[:code]
  p code
  client = get_user
  p client
  access_token = client.exchange_token(:code => code)
end
