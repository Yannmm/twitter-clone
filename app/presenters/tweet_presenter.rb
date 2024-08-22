class TweetPresenter
  include ActionView::Helpers::DateHelper
  def initialize(tweet)
    @tweet = tweet
  end

  attr_reader :tweet

  delegate :user, :body, to: :tweet

  delegate :avatar, :display_name, :username, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.utc.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end
end
