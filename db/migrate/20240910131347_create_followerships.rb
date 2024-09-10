class CreateFollowerships < ActiveRecord::Migration[7.1]
  def change
    create_table :followerships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :following_user, null: false, foreign_key: { to_table: :users }

      t.index %i[user_id following_user_id], unique: true

      t.timestamps
    end
  end
end
