class AddLongestStreakToUsers < ActiveRecord::Migration
  def change
    add_column :users, :longest_streak, :integer, default: 0
  end
end
