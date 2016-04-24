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
  client = get_user
  access_token = client.exchange_token(:code => code)
  id = session[:user_id] 
  destination = Destination.find_by(user_id: id)
  if destination
    destination.soundcloud_token = access_token[:access_token]
    destination.save
  else
    Destination.create(user_id: id, soundcloud_token: access_token[:access_token])
  end
  #client = Soundcloud.new(:access_token => access_token[:access_token])
  #soundcloud_user = client.get('/me')
  #puts soundcloud_user.username
  redirect "/users/#{session[:user_id]}"
end

