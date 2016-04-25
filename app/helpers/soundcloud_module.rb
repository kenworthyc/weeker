module SoundcloudModule
  def get_user
    client = SoundCloud.new(
      :client_id => ENV['SOUNDCLOUD_CLIENT_ID'], 
      :client_secret => ENV['SOUNDCLOUD_SECRET'],
      :redirect_uri => ENV['SOUNDCLOUD_CALLBACK']
    )
  end

  def upload_file(client, file_path)
    #puts client.get('/me').username
    puts Dir.pwd
    Dir.chdir("/Users/Tom/Desktop/")
    puts Dir.pwd
    puts File.new(file_path, 'rb')
    track = client.post('/tracks', :track => {
      :title => 'Listen to this!',
      :asset_data => File.new(file_path, 'rb')
    })
    track.permalink_url
  end
end

