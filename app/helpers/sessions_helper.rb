helpers do
  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_twitter_info
  	base = 'https://twitter.com'
  	# callback = 'http://weekerapp.heroku.com/twitter-authentication-return'
  	callback = 'http://localhost:9393/twitter-authentication-return'

  	consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'],
															 ENV['TWITTER_SECRET'],
															 { site: base } )

		request_token = consumer.get_request_token(oauth_callback: callback)
		session[:request_token] = request_token
		redirect request_token.authorize_url
  end

  def get_twitter_access_token
  	session[:access_token] = access_token = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
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

  def send_tweet
  	
  end

end