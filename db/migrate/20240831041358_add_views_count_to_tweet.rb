class AddViewsCountToTweet < ActiveRecord::Migration[7.1]
  def up
    add_column :tweets, :views_count, :integer, null: false, default: 0
  end

  def down
    remove_column :tweets, :views_count
  end
end
