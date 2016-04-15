class Destination < ActiveRecord::Base

  belongs_to :user
	validates  :twitter_token, presence: true
	validates  :twitter_secret, presence: true

end
