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

  def create_weekly_folder(client)

  end

  def move_dropbox_file(client, file_url, destination_url)
    #puts file_url
    #puts destination_url
    client.file_move(file_url, destination_url)
  end

  def name_archive_folder
    require 'date'
    now = Date.today
    week_ago = now - 7
    today = Time.now.strftime("%Y-%m-%d")
    "#{week_ago}_to_#{today}"
  end

  def create_archive_folder(client)
    path = "/archive/" + name_archive_folder 
    #add test for existence
    client.file_create_folder(path)
  end

  def tweet_all_images_in_folder(client)
    create_archive_folder(client)
    client.metadata('/this-week')["contents"].each do |image|
      image_path = image["path"]
      puts "image_path #{image_path}"
      content_url = client.media(image_path)["url"]
      puts "content_url #{content_url}"
      dropbox_url = content_url + "?dl=1"
      #twitter_media_upload("This is something:", dropbox_url)
      puts "Posted #{dropbox_url}"
      destination_url = image_path.gsub(/\/this-week/,'/archive')
      #move_dropbox_file(client, image_path, destination_url)
      sleep 5
    end
  end

end 
