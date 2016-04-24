class AddSoundcloudToken < ActiveRecord::Migration
  def change
    add_column :destinations, :soundcloud_token, :string
  end
end
