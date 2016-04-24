require 'tumblr_client'
module TumblrModule
	def get_tumblr_consumer
  	base = 'https://www.tumblr.com'
  	consumer = OAuth::Consumer.new(ENV['TUMBLR_KEY'],
															 ENV['TUMBLR_SECRET'],
															 { site: base,
															 	 # request_token_path: '/oauth/request_token',
															 	 # authorize_path: '/oauth/authorize',
															 	 # access_token_path: '/oauth/access_token',
															 	 # http_method: :post
															 	  } )
  end

  def get_tumblr_info
  	consumer = get_tumblr_consumer
  	request_token = consumer.get_request_token(oauth_callback: ENV['TUMBLR_CALLBACK'])
  	session[:tumblr_request_token] = request_token
		redirect request_token.authorize_url
  end

  def get_tumblr_access_token
  	session[:tumblr_access_token] = session[:tumblr_request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
  end
 
  def store_tumblr_access_token
  	id = session[:user_id]
  	token = session[:tumblr_access_token].token
  	secret = session[:tumblr_access_token].secret
  	destination = Destination.find_by(user_id: id)
  	if destination
  		destination.tumblr_secret = secret
  		destination.tumblr_token = token
  		destination.save
  	else
  		Destination.create(user_id: id, tumblr_secret: secret, tumblr_token: token)
  	end
  end

  def get_and_store_tumblr_blog_title
  	client = get_tumblr_client
  	blogs = []
  	client.info["user"]["blogs"].each do |blog|
  		blogs << blog["url"].split('/')[2]
  	end
  	erb :blog_selection, layout: false, locals: {blogs: blogs}
  end

  def store_tumblr_blog_title
  	
  end

  def get_tumblr_client
  	tokens = Destination.find_by(user_id: current_user.id)
    access_token = OAuth::AccessToken.new(get_consumer, tokens.tumblr_token, tokens.tumblr_secret)

  	Tumblr.configure do |config|
    	config.consumer_key = ENV["TUMBLR_KEY"]
			config.consumer_secret= ENV["TUMBLR_SECRET"]
			config.oauth_token = access_token.token
			config.oauth_token_secret = access_token.secret
    end

    client = Tumblr::Client.new
  end

	def tumblr_media_upload(status_msg, media_url, user_id = current_user.id)
    tokens = Destination.find_by(user_id: user_id)
    access_token = OAuth::AccessToken.new(get_consumer, tokens.tumblr_token, tokens.tumblr_secret)

    Tumblr.configure do |config|
    	config.consumer_key = ENV["TUMBLR_KEY"]
			config.consumer_secret= ENV["TUMBLR_SECRET"]
			config.oauth_token = access_token.token
			config.oauth_token_secret = access_token.secret
    end

    client = Tumblr::Client.new

	end
end