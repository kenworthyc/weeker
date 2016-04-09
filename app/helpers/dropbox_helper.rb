helpers do

  def make_dropbox_folder(name, client)
    if client.metadata(name) == nil
      client.file_create_folder(name)
    elsif client.metadata(name)["is_deleted"] == true
      client.file_create_folder(name)
    end
  end

	def dropbox_flow
		 DropboxOAuth2Flow.new( ENV['DROPBOX_KEY'],	ENV['DROPBOX_SECRET'], ENV['DROPBOX_CALLBACK'], session, :dropbox_token)
	end

  def tweet_all_images_in_folder(client)
    client.metadata('/this-week')["contents"].each do |image|
      image_path = image["path"]
      content_url = client.media(image_path)["url"]
      dropbox_url = content_url + "?dl=1"
      twitter_media_upload("This is something:", dropbox_url)
      puts "Posted #{dropbox_url}"
      sleep 5
    end
  end

end 
