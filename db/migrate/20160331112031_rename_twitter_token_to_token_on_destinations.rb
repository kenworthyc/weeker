class RenameTwitterTokenToTokenOnDestinations < ActiveRecord::Migration
  def change
  	rename_column :destinations, :twitter_token, :token
  end
end
