class AddTumblrBlogAddressFieldToDestinations < ActiveRecord::Migration
  def change
  	add_column :destinations, :tumblr_blog, :string
  end
end
