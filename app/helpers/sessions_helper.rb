helpers do
  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_consumer
  	base = 'https://twitter.com'
  	consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'],
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

  def send_tweet(user, status)
  	base = "https://api.twitter.com/1.1/statuses/update.json"
  	update = {'status' => status}
  	options = {'Accept' => 'application/xml'}
  	tokens = Destination.find_by(user_id: user.id)
  	access_token = OAuth::AccessToken.new(get_consumer, tokens.twitter_token, tokens.twitter_secret)
  	puts access_token.inspect
  	access_token.post(base, update, options)
  end

	def twitter_media_upload
		client = Twitter::REST::Client.new do |config|
			config.consumer_key =ENV["TWITTER_KEY"]
			config.consumer_secret=ENV["TWITTER_SECRET"]
			config.access_token=session[:access_token].token
			config.access_token_secret=session[:access_token].secret
		end
		client.update_with_media("Here's what I did this week:", 'https://dl.dropboxusercontent.com/s/ephkiagrqgfc0y4/IMG_8489.JPG?raw=1')
	end
end
