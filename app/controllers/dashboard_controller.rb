class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_presenters = Tweet.includes(:user,
                                       :likes,
                                       :liking_users,
                                       :bookmarks,
                                       :bookmarking_users,
                                       :retweets,
                                       :retweeting_users)
                             .order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
  end
end
