class AddStreakToUsers < ActiveRecord::Migration
  def change
    add_column :users, :streak_count, :integer, default: 0
  end
end
