class Followership < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: 'User'

  # 3. why this is necessary for "dependent: :destory"
  validates :user_id, uniqueness: { scope: :following_user_id }
end
