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
	puts session[:user_id]
	get_twitter_info
end

get '/twitter-authentication-return' do
	puts session.inspect
	puts session[:user_id]
	get_twitter_access_token
	# params[:oauth_verifier]
	# params[:oauth_token]
end
