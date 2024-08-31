class CreateViews < ActiveRecord::Migration[7.1]
  def change
    create_table :views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id tweet_id], unique: true
    end
  end
end
