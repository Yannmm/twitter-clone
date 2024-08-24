class TweetPresenter
  include ActionView::Helpers::DateHelper
  def initialize(tweet, current_user)
    @tweet = tweet
    @current_user = current_user
  end

  attr_reader :tweet

  delegate :user, :body, :likes, :liking_users, to: :tweet

  delegate :avatar, :display_name, :username, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.utc.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def liked?
    tweet.liking_users.include?(@current_user)
  end

  def like
    tweet.likes.find_by(user: @current_user)
  end
end
