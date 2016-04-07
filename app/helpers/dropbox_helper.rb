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
end 
