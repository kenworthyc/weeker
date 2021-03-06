module TwitterModule
  def get_consumer
    base = 'https://twitter.com'
    return OAuth::Consumer.new(ENV['TWITTER_KEY'], 
                               ENV['TWITTER_SECRET'], 
                               { site: base } )
  end

  def get_twitter_info
		request_token = get_consumer.get_request_token(oauth_callback: ENV['TWITTER_CALLBACK'])
		session[:request_token] = request_token
		redirect request_token.authorize_url
  end

  def get_twitter_access_token
  	session[:access_token] = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
  end
 
  def store_twitter_access_token
  	id = session[:user_id]
  	token = session[:access_token].token
  	secret = session[:access_token].secret
  	destination = Destination.find_by(user_id: id)
  	if destination
  		destination.twitter_secret = secret
  		destination.twitter_token = token
  		destination.save
  	else
  		Destination.create(user_id: id, twitter_secret: secret, twitter_token: token)
  	end
  end

	def twitter_media_upload(status_msg, media_url, user_id)
    tokens = Destination.find_by(user_id: user_id)
    access_token = OAuth::AccessToken.new(get_consumer, tokens.twitter_token, tokens.twitter_secret)

		client = Twitter::REST::Client.new do |config|
			config.consumer_key = ENV["TWITTER_KEY"]
			config.consumer_secret= ENV["TWITTER_SECRET"]
			config.access_token = access_token.token
			config.access_token_secret = access_token.secret
		end
		client.update_with_media(status_msg, open(media_url))
	end
end

