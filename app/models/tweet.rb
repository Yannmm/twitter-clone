class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }

  has_many :likes, dependent: :destroy

  has_many :liking_users, through: :likes, source: :user

  has_many :bookmarks, dependent: :destroy

  has_many :bookmarking_users, through: :bookmarks, source: :user

  has_many :retweets, dependent: :destroy

  has_many :retweeting_users, through: :retweets, source: :user

  has_many :views, dependent: :destroy

  has_many :viewing_users, through: :views, source: :user

  belongs_to :parent, foreign_key: :parent_id, inverse_of: :replies, class_name: 'Tweet', optional: true

  has_many :replies, foreign_key: :parent_id, class_name: 'Tweet'
end
