class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    # @bookmarks = current_user.bookmarked_tweets
    @tweet_presenters = current_user.bookmarked_tweets.map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
  end

  def create
    bookmark = current_user.bookmarks.build(tweet_id: params[:tweet_id])
    @source = params[:source]
    if bookmark.save
      @tweet_presenter = TweetPresenter.new(bookmark.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Bookmarked successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot bookmark this tweet.'
    end
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    @source = params[:source]
    if bookmark.destroy
      @tweet_presenter = TweetPresenter.new(bookmark.tweet, current_user)
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, notice: 'Unbookmark successfully'
        end
        format.turbo_stream
      end
    else
      redirect_to dashboard_path, alert: 'You cannot unbookmark this tweet.'
    end
  end
end
