class Followership < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:base, 'You cannot follow yourself') if follower_id == followee_id
  end
end
