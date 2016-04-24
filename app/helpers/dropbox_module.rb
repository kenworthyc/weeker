require_relative 'twitter_module'
include TwitterModule
module DropboxToTwitter
	def tweet_all_images_in_folder(client, user_id = current_user.id)
    archive_folder = create_archive_folder(client)
    if client.metadata('/this-week')["contents"].empty?
      twitter_media_upload("I made nothing this week. Posted via @weekerapp #weekerapp", "https://www.phactual.com/wp-content/uploads/2014/11/arrested-development-snoopy.jpg", user_id)
    else
      client.metadata('/this-week')["contents"].each do |image|
        image_path = image["path"]
        content_url = client.media(image_path)["url"]
        dropbox_url = content_url + "?dl=1"
        twitter_media_upload("This is something: Posted via @weekerapp #weekerapp", dropbox_url, user_id)
        destination_url = image_path.gsub(/\/this-week/,archive_folder)
        move_dropbox_file(client, image_path, destination_url)
        sleep 5
      end
    end
  end

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

  def move_dropbox_file(client, file_url, destination_url)
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
    "/archive/" + name_archive_folder
  end
end
