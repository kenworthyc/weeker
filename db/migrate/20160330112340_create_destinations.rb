class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.integer :user_id
      t.string  :twitter_token
    end
  end
end
