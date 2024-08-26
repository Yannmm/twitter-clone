class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    bookmark = current_user.bookmarks.build(tweet_id: params[:tweet_id])
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
