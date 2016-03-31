require 'dropbox_sdk'

get '/sources/new' do 
  erb :'sources/new'
end

#Dropbox Services
get '/sources/dropbox' do 
  flow = dropbox_flow
  authorize_url = flow.start() 
  redirect to (authorize_url)
end

get '/sources/dropbox-complete' do
	flow = dropbox_flow
  @session = session
  user_token= flow.finish(params)  
  Source.create(user_id:session[:user_id], dropbox_token:user_token[0]) 
  user = User.find(session[:user_id])
  @user_id = user.sources.first.dropbox_token
  erb :'sources/new'
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
