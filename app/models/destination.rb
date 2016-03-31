class Destination < ActiveRecord::Base

	validates :twitter_token, presence: true
	validates :twitter_secret, presence: true

end