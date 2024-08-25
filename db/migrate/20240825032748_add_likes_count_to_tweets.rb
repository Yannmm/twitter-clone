class AddLikesCountToTweets < ActiveRecord::Migration[7.1]
  def up
    add_column :tweets, :likes_count, :integer, null: false, default: 0

    Tweet.all.find_each do |tweet|
      Tweet.update_counters tweet.id, likes_count: tweet.likes.count
    end
  end

  def down
    remove_column :tweets, :likes_count
  end
end
