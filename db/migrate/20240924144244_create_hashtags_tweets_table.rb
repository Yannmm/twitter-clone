class CreateHashtagsTweetsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :hashtags_tweets, id: false do |t|
      t.belongs_to :hashtag
      t.belongs_to :tweet

      t.index %i[hashtag_id tweet_id], unique: true
      t.timestamps
    end
  end
end