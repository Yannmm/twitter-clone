class AddFollowersCountAndFolloweesCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :followees_count, :integer, null: false, default: 0

    User.all.find_each do |user|
      User.reset_counters user.id, :followees_count, :followers_count
    end
  end
end
