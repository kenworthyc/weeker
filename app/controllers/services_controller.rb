require 'dropbox_sdk'

#Dropbox Services

get '/new' do 
  erb :'test_db_link'
end

get '/service' do 
  flow = dropbox_flow
  authorize_url = flow.start() 
  redirect to (authorize_url)
end

get '/service_create' do
	flow = dropbox_flow
  @session = session
  @user_id = flow.finish(params)  
  erb :'test_db_link'
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
	send_tweet(User.find(session[:user_id]), "Weeker is now tweeting")
	redirect "/users/#{session[:user_id]}"
end