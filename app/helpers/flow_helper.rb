helpers do 
	def dropbox_flow
		 DropboxOAuth2Flow.new( ENV['DROPBOX_KEY'],	ENV['DROPBOX_SECRET'], 'http://localhost:9393/service_create', session, :dropbox_token)
	end
end
