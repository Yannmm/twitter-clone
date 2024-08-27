class AddRetweetsCountToTweets < ActiveRecord::Migration[7.1]
  def up
    add_column :tweets, :retweets_count, :integer, null: false, default: 0

    Tweet.all.find_each do |tweet|
      Tweet.update_counters tweet.id, retweets_count: tweet.retweets.count
    end
  end

  def down
    remove_column :tweets, :retweets_count
  end
end
