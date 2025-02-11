class TweetPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::DateHelper
  def initialize(tweet, current_user)
    @tweet = tweet
    @current_user = current_user
  end

  attr_reader :tweet

  delegate :likes_count, :retweets_count, :views_count, :replies_count, :user, :likes, to: :tweet

  delegate :display_name, :username, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.utc.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def body
    text = tweet.body.split(' ').map do |word|
      if word.start_with?('#')
        "<a class=\"twitter-link text-decoration-none\" href=''>#{word}</a>"
      else
        word
      end
    end.join(' ')

    text.html_safe
  end

  def avatar
    if tweet.user.avatar.attached?
      tweet.user.avatar
    else
      'anonymous.png'
    end
  end

  def liked?
    @liked ||= tweet.liking_users.include?(@current_user)
  end

  def like
    @like ||= tweet.likes.find_by(user: @current_user)
  end

  def like_path(source: nil)
    if liked?
      tweet_like_path(tweet, like, source:)
    else
      tweet_likes_path(tweet, source:)
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

  def like_text
    if tweet.likes_count.positive?
      tweet.likes_count.to_s
    else
      'Like'
    end
  end

  def bookmarked?
    @bookmarked ||= tweet.bookmarking_users.include?(@current_user)
  end

  def bookmark
    @bookmark ||= tweet.bookmarks.find_by(user: @current_user)
  end

  def bookmark_path(source: nil)
    if bookmarked?
      tweet_bookmark_path(tweet, bookmark, source:)
    else
      tweet_bookmarks_path(tweet, source:)
    end
  end

  def bookmark_method
    if bookmarked?
      :delete
    else
      :post
    end
  end

  def bookmark_image
    if bookmarked?
      'bookmark_fill.png'
    else
      'bookmark.png'
    end
  end

  def bookmark_text
    if bookmarked?
      'Bookmarked'
    else
      'Bookmark'
    end
  end

  def self_tweet?
    tweet.user == @current_user
  end

  def retweeted?
    @retweeted ||= tweet.retweeting_users.include?(@current_user)
  end

  def retweet
    @retweet ||= tweet.retweets.find_by(user: @current_user)
  end

  def retweet_path(source: nil)
    if retweeted?
      tweet_retweet_path(tweet, retweet, source:)
    else
      tweet_retweets_path(tweet, source:)
    end
  end

  def retweet_method
    if retweeted?
      :delete
    else
      :post
    end
  end

  def retweet_image
    if retweeted?
      'retweet_fill.png'
    else
      'retweet.png'
    end
  end

  def retweet_text
    if tweet.retweets_count.positive?
      tweet.retweets_count.to_s
    else
      'Retweet'
    end
  end

  def view_text
    tweet.views_count.to_s
  end

  def reply_text
    if tweet.replies_count.positive?
      tweet.replies_count.to_s
    else
      'Reply'
    end
  end
end
