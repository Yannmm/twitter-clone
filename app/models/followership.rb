class Followership < ApplicationRecord
  belongs_to :follower, class_name: 'User', counter_cache: :followees_count
  belongs_to :followee, class_name: 'User', counter_cache: :followers_count

  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:base, 'You cannot follow yourself') if follower_id == followee_id
  end
end
