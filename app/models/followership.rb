class Followership < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  # 3. why this is necessary for "dependent: :destory"
  # validates :follower_id, uniqueness: { scope: :followee_id }
end
