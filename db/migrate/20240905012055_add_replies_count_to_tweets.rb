class AddRepliesCountToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :replies_count, :integer, null: false, default: 0

    Tweet.all.find_each do |tweet|
      Tweet.reset_counters tweet.id, :replies
    end
  end
end
