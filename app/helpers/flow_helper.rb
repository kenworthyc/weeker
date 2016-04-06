helpers do 
	def dropbox_flow
		 DropboxOAuth2Flow.new( ENV['DROPBOX_KEY'],	ENV['DROPBOX_SECRET'], ENV['DROPBOX_CALLBACK'], session, :dropbox_token)
	end
end
