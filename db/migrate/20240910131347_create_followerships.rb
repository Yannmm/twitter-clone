class CreateFollowerships < ActiveRecord::Migration[7.1]
  def change
    create_table :followerships do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followee, null: false, foreign_key: { to_table: :users }

      t.index %i[follower_id followee_id], unique: true
      t.timestamps
    end
  end
end
