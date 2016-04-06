require 'dropbox_sdk'

get '/sources/new' do 
  @user = current_user 
  erb :'sources/new'
end

get '/sources/add-image' do
  @user = current_user
  client = DropboxClient.new(@user.dropbox_token)
  puts "*********************************************"
  puts "linked account:", client.account_info().inspect
  erb :'sources/add-image'
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
  @user = current_user 
  @user.dropbox_token = user_token[0]
  @user.save
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
