class AddSecretColumnToDestinationsTable < ActiveRecord::Migration
  def change
  	add_column :destinations, :secret, :string
  end
end
