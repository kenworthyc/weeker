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
