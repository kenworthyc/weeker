require 'dropbox_sdk'
flow = DropboxOAuth2FlowNoRedirect.new( '',  '')
get '/new' do 
  erb :'test_db_link'
end

get '/service' do 
  authorize_url = flow.start() 
  redirect to (authorize_url)
end

get '/service_create' do
  @user_id = flow.finish(params[:code])  
  erb :'test_db_link'
end

get '/twitter-authenticate' do
	get_twitter_info
end

get '/twitter-authentication-return' do
	get_twitter_access_token
	store_twitter_access_token
	redirect "/users/#{session[:user_id]}"
end
