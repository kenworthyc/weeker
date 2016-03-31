class AddSecretColumnToDestinationsTable < ActiveRecord::Migration
  def change
  	add_column :destinations, :twitter_secret, :string
  end
end
