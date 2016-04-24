require 'dropbox_sdk'
require 'twitter'
require 'open-uri'

get '/sources/new' do 
  @user = current_user 
  erb :'sources/new'
end

get '/sources/add-image' do
  @user = current_user
  client = DropboxClient.new(@user.dropbox_token)
  tweet_all_images_in_folder(client)
  redirect "/users/#{@user.id}"
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

  client = DropboxClient.new(@user.dropbox_token) 
  make_dropbox_folder("/this-week", client)
  make_dropbox_folder("/archive", client)
  copy_dropbox_file(client,"https://raw.githubusercontent.com/kenworthyc/weeker/blob/master/README.md","README.md")

  if @user.destinations.empty?
    redirect "/destinations/new"
  else
    redirect "/users/#{@user.id}"
  end
end

