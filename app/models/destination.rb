class Destination < ActiveRecord::Base

	validates :secret, presence: true
	validates :twitter_token, presence: true
end