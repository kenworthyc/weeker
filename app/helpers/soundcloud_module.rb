module SoundcloudModule
  def get_user
    client = SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'], 
  :client_secret => ENV['SOUNDCLOUD_SECRET'],
  :redirect_uri => ENV['SOUNDCLOUD_CALLBACK'])
  end
end
