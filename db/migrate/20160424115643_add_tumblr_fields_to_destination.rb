class AddTumblrFieldsToDestination < ActiveRecord::Migration
  def change
  	add_column :destinations, :tumblr_token, :string
  	add_column :destinations, :tumblr_secret, :string
  end
end
