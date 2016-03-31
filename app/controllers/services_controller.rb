require 'dropbox_sdk'

#Dropbox Services

get '/new' do 
  erb :'test_db_link'
end

get '/service' do 
  flow = DropboxOAuth2Flow.new( ENV['DROPBOX_KEY'],	ENV['DROPBOX_SECRET'], 'http://localhost:9393/service_create', session, :dropbox_token)
  authorize_url = flow.start() 
  redirect to (authorize_url)
end

get '/service_create' do
  flow = DropboxOAuth2Flow.new( ENV['DROPBOX_KEY'],	ENV['DROPBOX_SECRET'], 'http://localhost:9393/service_create', session, :dropbox_token)
  @session = session
  @user_id = flow.finish(params)  
  erb :'test_db_link'
end

#Twitter Services

get '/twitter-authenticate' do
	puts session[:user_id]
	get_twitter_info
end

get '/twitter-authentication-return' do
	puts session.inspect
	puts session[:user_id]
	get_twitter_access_token
	params[:oauth_verifier]
	params[:oauth_token]
end
