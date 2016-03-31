class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
     t.integer :user_id
     t.string  :dropbox_token
    end
  end
end
