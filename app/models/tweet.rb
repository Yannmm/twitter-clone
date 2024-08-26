class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }

  has_many :likes, dependent: :destroy

  has_many :liking_users, through: :likes, source: :user

  has_many :bookmarks, dependent: :destroy

  has_many :bookmarking_users, through: :bookmarks, source: :user
end
