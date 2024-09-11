class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :bookmarks, dependent: :destroy

  has_many :bookmarked_tweets, through: :bookmarks, source: :tweet

  has_many :retweets, dependent: :destroy

  has_many :retweeted_tweets, through: :retweets, source: :tweet

  has_many :views

  has_many :viewed_tweets, through: :views, source: :tweet

  has_many :who_i_follow, foreign_key: :follower_id, class_name: 'Followership'
  has_many :followees, through: :who_i_follow, dependent: :destroy

  has_many :who_follow_me, foreign_key: :followee_id, class_name: 'Followership'
  has_many :followers, through: :who_follow_me, dependent: :destroy

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  before_save :set_display_name, if: -> { username.present? && display_name.blank? }

  def set_display_name
    self.display_name = username.humanize
  end
end
