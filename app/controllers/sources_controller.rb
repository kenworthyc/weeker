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
  puts client.metadata('/this-week').inspect
  client.metadata('/this-week')["contents"].each do |image|
    image_path = image["path"]
    content_url = client.media(image_path)["url"]
    dropbox_url = content_url + "?dl=1"
    twitter_media_upload("This is something:", dropbox_url)
    puts "Posted #{dropbox_url}"
    sleep 60
  end
  # path = client.metadata('/')["contents"][1]["path"]
  # @content_url = client.media(path)["url"]
  # twitter_media_upload(media_url)
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

  client = DropboxClient.new(@user.dropbox_token) 
  make_dropbox_folder("/this-week", client)
  make_dropbox_folder("/archive", client)

  erb :'sources/new'
end

