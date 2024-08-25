class TweetPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::DateHelper
  def initialize(tweet, current_user)
    @tweet = tweet
    @current_user = current_user
  end

  attr_reader :tweet

  delegate :likes_count, :user, :body, :likes, to: :tweet

  delegate :display_name, :username, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.utc.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def liked?
    @liked ||= tweet.liking_users.include?(@current_user)
  end

  def like
    @like ||= tweet.likes.find_by(user: @current_user)
  end

  def avatar
    if tweet.user.avatar.attached?
      tweet.user.avatar
    else
      'anonymous.png'
    end
  end

  def like_path
    if liked?
      tweet_like_path(tweet, like)
    else
      tweet_likes_path(tweet)
    end
  end

  def like_method
    if liked?
      :delete
    else
      :post
    end
  end

  def like_image
    if liked?
      'like_fill.png'
    else
      'like.png'
    end
  end
end
