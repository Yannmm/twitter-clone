class AddParentIdToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :parent_id, :bigint
    add_foreign_key 'tweets', 'tweets', column: 'parent_id'

    add_index :tweets, %i[parent_id id]
  end
end
